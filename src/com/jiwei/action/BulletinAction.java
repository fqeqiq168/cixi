package com.jiwei.action;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.jiwei.entity.Affairs;
import com.jiwei.entity.Bulletin;
import com.jiwei.entity.Bulletin;
import com.jiwei.entity.Record;
import com.jiwei.entity.Useradmin;
import com.jiwei.entity.Zonenote;
import com.jiwei.entity.Bulletin;
import com.jiwei.jsonstatus.model.JsonResult;
import com.jiwei.service.entityService;

import io.swagger.annotations.Api;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;

@CrossOrigin(origins = "*")
@Controller
@Scope("prototype")
@Api(tags = "公告栏")
public class BulletinAction {
	private JsonConfig jsonConfig = new JsonConfig();
	private JSONArray json;
	@Autowired
	private entityService es;
	private static Logger logger = Logger.getLogger(BulletinAction.class);

	public void getJson1() throws Exception {
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
	}

	public void addRecord(Useradmin useradmin) throws Exception {
		Calendar ca = Calendar.getInstance();
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
		int maximum = ca.getActualMaximum(Calendar.DAY_OF_MONTH);
		int minmum = ca.getActualMinimum(Calendar.DAY_OF_MONTH);
		int day = ca.get(Calendar.DAY_OF_MONTH);
		Calendar cal = (Calendar) ca.clone();
		cal.add(Calendar.DATE, maximum - day);
		Date dateD = cal.getTime();
		String strD = f.format(dateD);
		cal = (Calendar) ca.clone();
		cal.add(Calendar.DATE, minmum - day);
		Date dateX = cal.getTime();
		String strX = f.format(dateX);
		List<String> ziduan = new ArrayList<String>();
		ziduan.add("useradmin.id");
		ziduan.add("date");
		List<Object> zhi = new ArrayList<Object>();
		zhi.add(useradmin.getId());
		zhi.add(dateX);
		zhi.add(dateD);
		List<Integer> type = new ArrayList<Integer>();
		type.add(0);
		type.add(9);
		List<Record> records = es.getObjectAllByTy(Record.class, true, 0, 1, ziduan, zhi, null, type, null, null, null);
		if (records != null && records.size() > 0) {
			Record record = records.get(0);
			record.setCount(record.getCount() + 1);
			es.caozuoObj(record, 1);
		} else {
			Record record = new Record();
			record.setCount(1);
			record.setUseradmin(useradmin);
			record.setDate(new Date());
			es.caozuoObj(record, 0);
		}
	}

	@RequestMapping(value = "admin/getBulletinall.do", method = RequestMethod.GET, produces = MediaType.TEXT_PLAIN_VALUE
			+ ";charset=utf-8")
	@ResponseBody
	public String admingetBulletinall(Integer start, Integer size, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		getJson1();
		if (start != null && size != null) {
			List<Object> sqlzd = new ArrayList<Object>();
			sqlzd.add("title");
			sqlzd.add("id");
			sqlzd.add("date");
			List<Bulletin> List = es.getObjectAllByTy(Bulletin.class, true, start, size, null, null, sqlzd, null, "id",
					null, null);
			if (List != null) {
				json = JSONArray.fromObject(List, jsonConfig);
				return JSONArray.fromObject(new JsonResult("200", "成功", json.toString())).toString();
			} else {
				return JSONArray.fromObject(new JsonResult("200", "成功", null)).toString();
			}
		} else {
			return JSONArray.fromObject(new JsonResult("200", "数据上传出错", null)).toString();
		}
	}

	@RequestMapping(value = "admin/delBulletin.do", method = RequestMethod.GET, produces = MediaType.TEXT_PLAIN_VALUE
			+ ";charset=utf-8")
	@ResponseBody
	public String delBulletin(Integer id, HttpSession session) throws Exception {
		getJson1();
		// System.out.println(SsUserAdmins.toString());
		synchronized (this) {
			Bulletin obj = (Bulletin) es.getObjectbyId(Bulletin.class, id, 0);
			if (obj != null) {
				es.caozuoObj(obj, 2);
				return JSONArray.fromObject(new JsonResult("200", "成功", null)).toString();
			} else {
				return JSONArray.fromObject(new JsonResult("200", "不存在", null)).toString();
			}
		}
	}

	@RequestMapping(value = "getBulletinall.do", method = RequestMethod.GET, produces = MediaType.TEXT_PLAIN_VALUE
			+ ";charset=utf-8")
	@ResponseBody
	public String getBulletinall(Integer start, Integer size, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		getJson1();
		if (start != null && size != null) {
			List<Object> sqlzd = new ArrayList<Object>();
			sqlzd.add("title");
			sqlzd.add("date");
			sqlzd.add("id");
			List<Bulletin> List = es.getObjectAllByTy(Bulletin.class, true, start, size, null, null, sqlzd, null, "id",
					null, null);
			Integer number  = es.getObjectAllByTyCount(Bulletin.class, true, null, null, null, null, null);
			if (List != null) {
				for (int i = 0; i < List.size(); i++) {
					List.get(i).setTitle(StringEscapeUtils.unescapeHtml4(List.get(i).getTitle()));
				}
				// json = JSONArray.fromObject(List, jsonConfig);
				return JSONArray.fromObject(new JsonResult("200", "成功",
						JSON.toJSONString(List, SerializerFeature.WriteDateUseDateFormat), number)).toString();
			} else {
				return JSONArray.fromObject(new JsonResult("400", "无数据", null)).toString();
			}
		} else {
			return JSONArray.fromObject(new JsonResult("400", "数据上传出错", null)).toString();
		}
	}

	@RequestMapping(value = "findBulletinById.do", method = RequestMethod.GET, produces = MediaType.TEXT_PLAIN_VALUE
			+ ";charset=utf-8")
	@ResponseBody
	public String findBulletinById(Integer Id,Integer updown, HttpSession session) throws Exception {
		getJson1();
		// System.out.println(SsUserAdmins.toString());
		if (Id != null) {
			List<Object> sqlzd = new ArrayList<Object>();
			List<String> ziduan = new ArrayList<String>();
			List<Integer> type = new ArrayList<Integer>();
			List<Object> zhi = new ArrayList<Object>();
			sqlzd.add("title");
			sqlzd.add("date");
			sqlzd.add("content");
			sqlzd.add("id");
			ziduan.add("id");
			zhi.add(Id);
			String odb = null;
			if (updown != null) {
				if (updown > 0) {
					type.add(8);
				} else {
					type.add(10);
					odb = "id";
				}
			} else {
				type.add(0);
			}
			List<Bulletin> List = es.getObjectAllByTy(Bulletin.class, true, null, null, ziduan, zhi, sqlzd, type, odb,
					null, null);
			if (List != null && List.size() > 0) {
				// JSONObject json = JSONObject.fromObject(List.get(0));
				for (int i = 0; i < List.size(); i++) {
					List.get(i).setTitle(StringEscapeUtils.unescapeHtml4(List.get(i).getTitle()));
					List.get(i).setContent(StringEscapeUtils.unescapeHtml4(List.get(i).getContent()));
				}
				return JSONArray.fromObject(new JsonResult("200", "成功",
						JSON.toJSONString(List.get(0), SerializerFeature.WriteDateUseDateFormat))).toString();
			} else {
				return JSONArray.fromObject(new JsonResult("400", "请检查信息是否为空", null)).toString();
			}
		} else {
			return JSONArray.fromObject(new JsonResult("400", "请检查信息是否为空", null)).toString();
		}
	}

	@RequestMapping(value = "admin/addBulletin.do", method = RequestMethod.POST, produces = MediaType.TEXT_PLAIN_VALUE
			+ ";charset=utf-8")
	@ResponseBody
	public String addBulletin(@ModelAttribute Bulletin obj, HttpSession session) throws Exception {
		getJson1();
		if (obj != null && obj.getTitle() != null) {
			synchronized (this) {
				// System.out.println(Useradmins.toString());
				Useradmin useradmin = (Useradmin) session.getAttribute("useradmin");
				obj.setUseradmin(useradmin);
				if (es.getObject(new Bulletin(obj.getTitle())) != null) {
					return JSONArray.fromObject(new JsonResult("200", "标题已存在", null)).toString();
				} else {
					obj.setDate(new Timestamp(new Date().getTime()));
					if (es.caozuoObj(obj, 0)) {
						addRecord(useradmin);
						return JSONArray.fromObject(new JsonResult("200", "成功", null)).toString();
					} else {
						return JSONArray.fromObject(new JsonResult("200", "失败", null)).toString();
					}
				}
			}
		} else {
			return JSONArray.fromObject(new JsonResult("200", "请检查信息是否为空", null)).toString();
		}
	}

	@RequestMapping(value = "admin/updateBulletin.do", method = RequestMethod.POST, produces = MediaType.TEXT_PLAIN_VALUE
			+ ";charset=utf-8")
	@ResponseBody
	public String updateBulletin(@ModelAttribute Bulletin obj, HttpSession session) throws Exception {
		getJson1();
		// System.out.println(SsUserAdmins.toString());
		if (obj != null && obj.getId() != null && obj.getTitle() != null) {
			Bulletin obj1 = null;
			synchronized (this) {
				obj1 = (Bulletin) es.getObjectbyZd(Bulletin.class, "title", obj.getTitle(), true);
				if (obj1 != null && !obj1.getId().equals(obj.getId())) {
					return JSONArray.fromObject(new JsonResult("200", "已存在同样标题", null)).toString();
				} else {
					Useradmin useradmin = (Useradmin) session.getAttribute("useradmin");
					obj.setUseradmin(useradmin);
					obj1=(Bulletin) es.getObjectbyId(Bulletin.class, obj.getId(), 0);
					obj1=(Bulletin) BeanUtilIgnoreNull.copyPropertiesIgnoreNull(obj, obj1);
					es.caozuoObj(obj1, 1);
					return JSONArray.fromObject(new JsonResult("200", "成功", null)).toString();
				}
			}
		} else {
			return JSONArray.fromObject(new JsonResult("200", "请检查信息是否为空", null)).toString();
		}
	}

	@RequestMapping(value = "admin/findBulletinById.do", method = RequestMethod.GET, produces = MediaType.TEXT_PLAIN_VALUE
			+ ";charset=utf-8")
	@ResponseBody
	public String adminfindBulletinById(Integer Id, HttpSession session) throws Exception {
		getJson1();
		// System.out.println(SsUserAdmins.toString());
		if (Id != null) {
			Bulletin obj1 = (Bulletin) es.getObjectbyId(Bulletin.class, Id, 0);
			if (obj1 != null) {
				JSONObject json = JSONObject.fromObject(obj1);
				return JSONArray.fromObject(new JsonResult("200", "成功", json.toString())).toString();
			} else {
				return JSONArray.fromObject(new JsonResult("200", "请检查信息是否为空", null)).toString();
			}
		} else {
			return JSONArray.fromObject(new JsonResult("200", "请检查信息是否为空", null)).toString();
		}
	}
}
