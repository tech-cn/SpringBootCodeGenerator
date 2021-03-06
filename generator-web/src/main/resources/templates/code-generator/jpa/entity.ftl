package ${packageName}.entity;

<#--import lombok.Data;-->
import java.util.Date;
import java.math.BigDecimal;
// import java.util.List;
import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.GeneratedValue;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
<#--  import com.fasterxml.jackson.annotation.JsonProperty;  -->

/**
 * @description ${classInfo.classComment}
 * @author ${authorName}
 * @date ${.now?string('yyyy-MM-dd HH:mm:ss')}
 */
@Entity
<#--@Data-->
@Table(name="${classInfo.tableName}")<#if swagger?exists && swagger==true>
@ApiModel("${classInfo.classComment}")</#if>
public class ${classInfo.className} implements Serializable {
    public ${classInfo.className}() {
    }
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue
<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
<#list classInfo.fieldList as fieldItem >
    /**
    * ${fieldItem.fieldComment}
    */<#if swagger?exists && swagger==true>
    @ApiModelProperty("${fieldItem.fieldComment}")</#if>
    @Column(name="${fieldItem.columnName}")
    <#--  @JsonProperty("${fieldItem.columnName}")  -->
    private ${fieldItem.fieldClass} ${fieldItem.fieldName};

</#list>


    <#list classInfo.fieldList as fieldItem>
        public ${fieldItem.fieldClass} get${fieldItem.fieldName?cap_first}() {
            return ${fieldItem.fieldName};
        }

        public void set${fieldItem.fieldName?cap_first}(${fieldItem.fieldClass} ${fieldItem.fieldName}) {
            this.${fieldItem.fieldName} = ${fieldItem.fieldName};
        }

    </#list>
</#if>

}
