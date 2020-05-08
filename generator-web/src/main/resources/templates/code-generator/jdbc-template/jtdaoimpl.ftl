import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
<#--  import org.springframework.jdbc.core.JdbcTemplate;  -->
import org.springframework.stereotype.Repository;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import java.util.List;
import java.util.Map;

/**
 * @description ${classInfo.classComment}
 * @author ${authorName}
 * @date ${.now?string('yyyy-MM-dd HH:mm:ss')}
 */
@Repository
public class ${classInfo.className}DaoImpl implements I${classInfo.className}Dao{

    @Autowired
    private NamedParameterJdbcTemplate nameJdbcTemplate;

    <#--  private String cols6="<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem >${fieldItem.columnName}<#if fieldItem_has_next>,</#if></#list></#if>";  -->
    @Override
    public int add(${classInfo.className} ${classInfo.className?uncap_first}) {
        SqlParameterSource paramSource=new BeanPropertySqlParameterSource(${classInfo.className?uncap_first});
        return nameJdbcTemplate.update("insert into ${classInfo.tableName}(<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem >${fieldItem.columnName}<#if fieldItem_has_next>,</#if></#list></#if>) values (<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem >:${fieldItem.columnName}<#if fieldItem_has_next>,</#if></#list></#if>)",
        paramSource);       
    }

    @Override
    public int update(${classInfo.className} ${classInfo.className?uncap_first}) {
        SqlParameterSource paramSource=new BeanPropertySqlParameterSource(${classInfo.className?uncap_first});
        return nameJdbcTemplate.update("update ${classInfo.tableName} set <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem ><#if fieldItem_index gt 0 >${fieldItem.columnName}=:${fieldItem.columnName}<#if fieldItem_has_next>,</#if></#if></#list></#if>"
        +" where <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem ><#if fieldItem_index = 0>${fieldItem.columnName}=:${fieldItem.columnName}<#break ></#if></#list></#if>",
        paramSource);
    }

    @Override
    public int delete(String id) {
        MapSqlParameterSource paramSource = new MapSqlParameterSource();
        paramSource.addValue("<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem ><#if fieldItem_index = 0>${fieldItem.columnName}<#break ></#if></#list></#if>", id);
        return nameJdbcTemplate.update("delete from ${classInfo.tableName} where <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem ><#if fieldItem_index = 0>${fieldItem.columnName}=:${fieldItem.columnName}<#break ></#if></#list></#if>",
        paramSource);
    }

    @Override
    public ${classInfo.className} load(String id) {
        MapSqlParameterSource paramSource = new MapSqlParameterSource();
        paramSource.addValue("<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem ><#if fieldItem_index = 0>${fieldItem.columnName}<#break ></#if></#list></#if>", id);
        ${classInfo.className} ${classInfo.className?uncap_first} = nameJdbcTemplate.queryForObject("select <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem >${fieldItem.columnName}<#if fieldItem_has_next>,</#if></#list></#if> from ${classInfo.tableName} where <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem ><#if fieldItem_index = 0>${fieldItem.columnName}=:${fieldItem.columnName}<#break ></#if></#list></#if>",paramSource,new BeanPropertyRowMapper<${classInfo.className}>(${classInfo.className}.class));
        if(${classInfo.className?uncap_first}!=null){
            return ${classInfo.className?uncap_first};
        }else{
             return null;
        }
    }

    @Override
    public List<${classInfo.className}> loadPage(Map<String,Object> params) {
        int currPage= (int) params.get("currPage");
        int pageSize= (int) params.get("pageSize");        
        StringBuilder stb=new StringBuilder();
        stb.append("select <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0><#list classInfo.fieldList as fieldItem >${fieldItem.columnName}<#if fieldItem_has_next>,</#if></#list></#if>");
        stb.append(" from ${classInfo.tableName} where 1=1");
        if(params.get("filter")!=null && !params.get("filter").toString().trim().equals("")){
            stb.append(" and (SelectName like :filter)");
            StringBuilder st=new StringBuilder();
            st.append("%");
            st.append(params.get("filter"));
            st.append("%");
            params.put("filter", st.toString());
        }
        stb.append(" limit :pageSize offset :offsetNo");
        int offsetNo = (currPage - 1) * pageSize;
        params.put("offsetNo",offsetNo);
        List<${classInfo.className}> list = nameJdbcTemplate.query(stb.toString(), params, new BeanPropertyRowMapper<${classInfo.className}>(${classInfo.className}.class));   
        if(list!=null && list.size()>0){
            return list;
        }else{
            return null;
        }
    }

    @Override
    public int count(Map<String, Object> params) {     
        StringBuilder stb=new StringBuilder();
        stb.append("select count(1) from ${classInfo.tableName} where 1=1");
        if(params.get("filter")!=null && !params.get("filter").toString().trim().equals("")){
            stb.append(" and (SelectName like :filter)");
            StringBuilder st=new StringBuilder();
            st.append("%");
            st.append(params.get("filter"));
            st.append("%");
            params.put("filter", st.toString());
        }
        int num=nameJdbcTemplate.queryForObject(stb.toString(),params,Integer.class);
        return num;
    }
    
    @Override
    public int isExist(String selectName){
        MapSqlParameterSource paramSource = new MapSqlParameterSource();
        paramSource.addValue("selectName", selectName);
        String sql="select count(1) from ${classInfo.tableName} where SelectName=:SelectName";
        return nameJdbcTemplate.queryForObject(sql,paramSource,Integer.class);
    }

}
