package com.shorty.app.entity;

import org.springframework.data.mongodb.core.mapping.Document;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
@Document(collection = "redirect")
public class Redirect {

    @Id
    @GeneratedValue
    private String id;

    @Column(unique = true, nullable = false)
    private String alias;

    @Column(nullable = false)
    private String url;

    public Redirect(final String alias, final String url) {
        this.alias = alias;
        this.url = url;
    }

    @Override
    public String toString() {
        return "Redirect{" + "id=" + id + ", alias='" + alias + '\'' + ", url='" + url + '\'' + '}';
    }

    public String getId() {
        return id;
    }

    public String getAlias() {
        return alias;
    }

    public String getUrl() {
        return url;
    }
}
