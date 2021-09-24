package com.braker.common.entity;

public abstract class AbstractEntity implements Entity {

    protected AbstractEntity()
    {}

    public boolean equals(Object o)
    {
        if (this == o)
            return true;

        if (o == null)
            return false;

        if (!(o instanceof Entity))
            return false;

        if (getId() == null || ((Entity) o).getId() == null)
            return false;

        return (getId().equals(((Entity) o).getId()));
    }

    public int hashCode()
    {
        int hash = 1;
        hash = hash * 31 + (getId() == null ? 0 : getId().hashCode());
        return hash;
    }

    public String toString()
    {
        return (this.getClass().getName() + ":" + getId());
    }
}
