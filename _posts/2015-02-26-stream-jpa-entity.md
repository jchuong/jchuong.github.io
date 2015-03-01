---
layout: post
title: Stream Functions in a JPA Entity?
tags: programming
---

A quick little post on a random issue I ran into today.  I don't exactly have a good explanation for this as of yet but here's a quick tip if you run into this problem.

So let's define an entity for persistence (we're using JPA and Eclipselink, to a Postgres database).

{% highlight java %}
@Entity
class Foo implements Serializable {
  private final long serializeUID = 1L;

  @Id @GeneratedValue
  private long id;

  public long bar;
  public long baz;
}
{% endhighlight %}

Simple. Now, what if we're developing a front-end that queries the database, and we want to list out the fields of `Foo`.  So let's use reflection to list the fields, and use Java 8 stream operators.

{% highlight java %}
@Entity
class Foo implements Serializable {
  ...

  public static final List<String> getMemberNames() {
    return Arrays.asList(Foo.class.getFields()).stream().map(field -> field.getName()).collect(Collectors.toList());
  }
}
{% endhighlight %}

And so that looks pretty good.  Except now JPA does not generate this into the database (fails validation).

However this would work:

{% highlight java %}
@Entity
class Foo implements Serializable {
  ...

  public static final List<String> getMemberNames() {
      ArrayList<String> fields = new ArrayList<String>();
      for (Field field : Foo.class.getFields()) {
        fields.add(field.getName());
      }
      return fields;
  }
}
{% endhighlight %}

But that isn't as cool as using streams.  So this also works, but moving the reflection to another class; in this case the DAO.

{% highlight java %}
class JpaDAO {
  public static final List<String> getFooMemberNames() {
    return Arrays.asList(Foo.class.getFields()).stream().map(field -> field.getName()).collect(Collectors.toList());
  }
}
{% endhighlight %}
