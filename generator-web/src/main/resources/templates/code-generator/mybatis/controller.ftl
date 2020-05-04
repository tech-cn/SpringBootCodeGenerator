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
import io.swagger.annotations.Api;
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
@Api(tags = "接口")
@RestController
@RequestMapping(value = "/api/v1/${classInfo.className}")
public class ${classInfo.className}Controller {

    <#--  //@Resource
    //private ${classInfo.className}Service ${classInfo.className?uncap_first}Service;  -->
    
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
    @PostMapping("/")
    public int insert(@RequestBody ${classInfo.className} ${classInfo.className?uncap_first}){
        String creater=request.getAttribute("userId").toString();
        ${classInfo.className?uncap_first}.setCreater(creater);
        ${classInfo.className?uncap_first}.setCreateDate(new Date());
        return i${classInfo.className}Dao.add(${classInfo.className?uncap_first});
    }

    /**
    * 刪除
    * @author ${authorName}
    * @date ${.now?string('yyyy/MM/dd')}
    **/
    @ApiOperation(value = "刪除", notes = "")
    @DeleteMapping("/{id}")
    public int delete(@ApiParam(value = "id", required = true) @PathVariable("id") String id){
        return i${classInfo.className}Dao.delete(id);
    }

    /**
    * 更新
    * @author ${authorName}
    * @date ${.now?string('yyyy/MM/dd')}
    **/
    @ApiOperation(value = "更新", notes = "")
    @PutMapping("/{id}")
    public int update(@RequestBody ${classInfo.className} ${classInfo.className?uncap_first},
        @ApiParam(value = "id", required = true) @PathVariable("id") String id){
        return i${classInfo.className}Dao.update(${classInfo.className?uncap_first});
    }

    /**
    * 查询 根据主键 id 查询
    * @author ${authorName}
    * @date ${.now?string('yyyy/MM/dd')}
    **/
    @ApiOperation(value = "查询 根据主键 id 查询", notes = "")
    @GetMapping("/{id}")
    public ${classInfo.className} load(@ApiParam(value = "id", required = true) @PathVariable("id") String id){
        return i${classInfo.className}Dao.load(id);
    }

    /**
    * 查询 分页查询
    * @author ${authorName}
    * @date ${.now?string('yyyy/MM/dd')}
    **/
    @ApiOperation(value = "分页", notes = "分页查询")
    @PostMapping("/list")
    public Map<String, Object> pageList(@RequestBody Map<String, Object> param) {
        int count = i${classInfo.className}Dao.count(param);
        List<${classInfo.className}> list = i${classInfo.className}Dao.loadPage(param);
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("list", list);
        result.put("count", count);
        return result;
    }
}
