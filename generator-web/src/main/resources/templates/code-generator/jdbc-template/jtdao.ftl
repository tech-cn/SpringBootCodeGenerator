
import java.util.List;

/**
 * @description ${classInfo.classComment}
 * @author ${authorName}
 * @date ${.now?string('yyyy-MM-dd HH:mm:ss')}
 */
public interface I${classInfo.className}Dao {

    int add(${classInfo.className} ${classInfo.className?uncap_first});

    int update(${classInfo.className} ${classInfo.className?uncap_first});

    int delete(String id);

    ${classInfo.className} load(String id);

    List<${classInfo.className}> loadPage(Map<String,Object> param);
    
    int count(Map<String,Object> param);

    int isExist(String userName);
}
