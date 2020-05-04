import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @description ${classInfo.classComment}
 * @author ${authorName}
 * @date ${.now?string('yyyy-MM-dd HH:mm:ss')}
 */
@Repository
public class ${classInfo.className}DaoImpl implements I${classInfo.className}Dao{

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private String cols6="<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem >${fieldItem.columnName}<#if fieldItem_has_next>,</#if></#list></#if>";
    @Override
    public int add(${classInfo.className} ${classInfo.className?uncap_first}) {
        return jdbcTemplate.update("insert into ${classInfo.tableName}(<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem >${fieldItem.columnName}<#if fieldItem_has_next>,</#if></#list></#if>) values (<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem >?<#if fieldItem_has_next>,</#if></#list></#if>)",
        <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem >${classInfo.className?uncap_first}.get${fieldItem.fieldName?cap_first}()<#if fieldItem_has_next>,</#if></#list></#if>);
        
    }

    @Override
    public int update(${classInfo.className} ${classInfo.className?uncap_first}) {
        return jdbcTemplate.update("update ${classInfo.tableName} set <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem ><#if fieldItem_index gt 0 >${fieldItem.columnName}=?<#if fieldItem_has_next>,</#if></#if></#list></#if>"
        +" where <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem ><#if fieldItem_index = 0>${fieldItem.columnName}=?<#break ></#if></#list></#if>",
        <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
            <#list classInfo.fieldList as fieldItem ><#if fieldItem_index gt 0 >${classInfo.className?uncap_first}.get${fieldItem.fieldName?cap_first}(),</#if></#list>
            <#list classInfo.fieldList as fieldItem ><#if fieldItem_index = 0 >${classInfo.className?uncap_first}.get${fieldItem.fieldName?cap_first}()</#if></#list>
        </#if>);
    }

    @Override
    public int delete(String id) {
        return jdbcTemplate.update("delete from ${classInfo.tableName} where <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem ><#if fieldItem_index = 0>${fieldItem.columnName}=?<#break ></#if></#list></#if>",id);
    }

    @Override
    public ${classInfo.className} load(String id) {
        List<${classInfo.className}> list = jdbcTemplate.query("select * from ${classInfo.tableName} where <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem ><#if fieldItem_index = 0>${fieldItem.columnName}=?<#break ></#if></#list></#if>", new Object[]{id}, new BeanPropertyRowMapper<${classInfo.className}>(${classInfo.className}.class));
        if(list!=null && list.size()>0){
            ${classInfo.className} ${classInfo.className?uncap_first} = list.get(0);
            return ${classInfo.className?uncap_first};
        }else{
             return null;
        }
    }

    @Override
    public List<${classInfo.className}> loadPage(Map<String,Object> params) {
        List<${classInfo.className}> list = jdbcTemplate.query("select * from ${classInfo.tableName} limit ? offset ?", new Object[]{}, new BeanPropertyRowMapper<${classInfo.className}>(${classInfo.className}.class));
        if(list!=null && list.size()>0){
            return list;
        }else{
            return null;
        }
    }
    @Override
    public int count(Map<String, Object> params) {
        String sql="select count(1) from ${classInfo.tableName}";
        int num=jdbcTemplate.queryForObject(sql,Integer.class);
        return num;
    }
    @Override
    public int isExist(String roleName){
        String sql="select count(1) from Sys_Role where RoleName=?";
        return jdbcTemplate.queryForObject(sql,Integer.class,roleName);
    }

}
