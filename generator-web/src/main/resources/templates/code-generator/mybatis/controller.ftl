import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.HashMap;
<#--  import javax.annotation.Resource;  -->
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;
import java.util.Date;

/**
 * @description ${classInfo.classComment}
 * @author ${authorName}
 * @date ${.now?string('yyyy-MM-dd HH:mm:ss')}
 */
@RestController
@RequestMapping(value = "/${classInfo.className}")
public class ${classInfo.className}Controller {

    //@Resource
    //private ${classInfo.className}Service ${classInfo.className?uncap_first}Service;
    
    @Autowired
    private I${classInfo.className}Dao i${classInfo.className}Dao;

    @Autowired
    private HttpServletRequest request;

    /**
    * 新增
    * @author ${authorName}
    * @date ${.now?string('yyyy/MM/dd')}
    **/
    @ApiOperation(value = "新增", notes = "")
    @PostMapping("/add")
    public int insert(${classInfo.className} ${classInfo.className?uncap_first}){
        String creater=request.getAttribute("userId").toString();
        ${classInfo.className?uncap_first}.setCreater(creater);
        ${classInfo.className?uncap_first}.setCreateDate(new Date());
        return i${classInfo.className?uncap_first}Dao.add(${classInfo.className?uncap_first});
    }

    /**
    * 刪除
    * @author ${authorName}
    * @date ${.now?string('yyyy/MM/dd')}
    **/
    @ApiOperation(value = "刪除", notes = "")
    @DeleteMapping("/{id}")
    public int delete(String id){
        return i${classInfo.className?uncap_first}Dao.delete(id);
    }

    /**
    * 更新
    * @author ${authorName}
    * @date ${.now?string('yyyy/MM/dd')}
    **/
    @ApiOperation(value = "更新", notes = "")
    @PutMapping("/update")
    public int update(${classInfo.className} ${classInfo.className?uncap_first}){
        return i${classInfo.className?uncap_first}Dao.update(${classInfo.className?uncap_first});
    }

    /**
    * 查询 根据主键 id 查询
    * @author ${authorName}
    * @date ${.now?string('yyyy/MM/dd')}
    **/
    @ApiOperation(value = "查询 根据主键 id 查询", notes = "")
    @GetMapping("/{id}")
    public ${classInfo.className} load(String id){
        return i${classInfo.className?uncap_first}Dao.load(id);
    }

    /**
    * 查询 分页查询
    * @author ${authorName}
    * @date ${.now?string('yyyy/MM/dd')}
    **/
    @ApiOperation(value = "分页", notes = "分页查询")
    @PostMapping("/list")
    public Map<String, Object> pageList(@RequestBody Map<String, Object> param) {
        int count = i${classInfo.className?uncap_first}Dao.count(param);
        List<${classInfo.className}> list = i${classInfo.className?uncap_first}Dao.loadPage(param);
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("list", list);
        result.put("count", count);
        return result;
    }
}
