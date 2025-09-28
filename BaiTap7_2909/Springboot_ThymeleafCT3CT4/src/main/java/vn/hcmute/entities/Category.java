package vn.hcmute.entities;

import java.io.Serializable;
import java.util.Set;

import jakarta.persistence.*;
import lombok.*;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "categories")
public class Category implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 200)
    private String name;

    @Column(name = "image")
    private String image;

    @Column(name = "is_show")
    private Boolean show = Boolean.TRUE;

    @Column(name = "is_sub_home")
    private Boolean subHome = Boolean.FALSE;

    @Column(name = "sort_order")
    private Integer sortOrder = 1;

    @JsonIgnore
    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL)
    private Set<Product> products;

    // ==== Getter & Setter thủ công ====
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }

    public Boolean getShow() {
        return show;
    }
    public void setShow(Boolean show) {
        this.show = show;
    }

    public Boolean getSubHome() {
        return subHome;
    }
    public void setSubHome(Boolean subHome) {
        this.subHome = subHome;
    }

    public Integer getSortOrder() {
        return sortOrder;
    }
    public void setSortOrder(Integer sortOrder) {
        this.sortOrder = sortOrder;
    }
}
