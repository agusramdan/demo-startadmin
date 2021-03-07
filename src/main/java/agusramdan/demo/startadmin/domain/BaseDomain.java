package agusramdan.demo.startadmin.domain;

import com.fasterxml.jackson.core.SerializableString;

public interface BaseDomain <ID>{

    ID getId();
    void setId(ID id);

}
