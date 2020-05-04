import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * @description ${classInfo.classComment}
 * @author ${authorName}
 * @date ${.now?string('yyyy-MM-dd HH:mm:ss')}
 */
@RestController
@RequestMapping(value = "/${classInfo.className}")
public class ${classInfo.className}Controller {

    @Resource
    private ${classInfo.className}Service ${classInfo.className?uncap_first}Service;
    
    @Autowired
    private ${classInfo.className}Dao ${classInfo.className?uncap_first}Dao;

    @Autowired
    private HttpServletRequest request;

    /**
    * 新增
    * @author ${authorName}
    * @date ${.now?string('yyyy/MM/dd')}
    **/
    @PostMapping("/add")
    public int insert(${classInfo.className} ${classInfo.className?uncap_first}){
        String creater=request.getAttribute("userId").toString();
        sysRole.setCreater(creater);
        sysRole.setCreateDate(new Date());
        return ${classInfo.className?uncap_first}Dao.insert(${classInfo.className?uncap_first});
    }

    /**
    * 刪除
    * @author ${authorName}
    * @date ${.now?string('yyyy/MM/dd')}
    **/
    @DeleteMapping("/{id}")
    public int delete(String id){
        return ${classInfo.className?uncap_first}Dao.delete(id);
    }

    /**
    * 更新
    * @author ${authorName}
    * @date ${.now?string('yyyy/MM/dd')}
    **/
    @PutMapping("/update")
    public int update(${classInfo.className} ${classInfo.className?uncap_first}){
        return ${classInfo.className?uncap_first}Dao.update(${classInfo.className?uncap_first});
    }

    /**
    * 查询 根据主键 id 查询
    * @author ${authorName}
    * @date ${.now?string('yyyy/MM/dd')}
    **/
    @GetMapping("/{id}")
    public ReturnT<String> load(String id){
        return ${classInfo.className?uncap_first}Dao.load(id);
    }

    /**
    * 查询 分页查询
    * @author ${authorName}
    * @date ${.now?string('yyyy/MM/dd')}
    **/
    @ApiOperation(value = "分页", notes = "分页查询")
    @PostMapping("/list")
    public Map<String, Object> pageList(@RequestBody Map<String, Object> param) {
        int count = ${classInfo.className?uncap_first}Dao.count(param);
        List<${classInfo.className}> list = ${classInfo.className?uncap_first}Dao.loadPage(param);
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("list", list);
        result.put("count", count);
        return result;
    }
}
