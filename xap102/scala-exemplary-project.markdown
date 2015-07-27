---
layout: post102
title:  Exemplary Project
categories: XAP102
parent: scala.html
weight: 600
---

There has been created a project that shows how certain features of XAP Scala can be used in real project and how Scala and Java code might be integrated.

# <a name="openspaces_maven_plugin_project"/>OpenSpaces Maven plugin project

The project is based on a template project of `basic` type from the `OpenSpaces Maven plugin`. Obviously, a few changes were introduced:

- `Common` module, which implements spaces classes, has been rewritten in Scala and takes advantage of constructor based properties.
- A new module - `verifier` - has been created. It uses a class with constructor based properties and predicate based queries to obtain objects from space.
- Build process of `common` and `verifier` modules has been modified to handle Scala and mixed Java/Scala modules, respectively.

# <a name="build_run"/>Build & run

## Requirements
1. JDK in version at least 1.6 is required to build the project.
2. The project uses `maven` build tool.
3. To run the project, Scala libraries have to be a accessible for XAP.

Please note that Scala is not required to build the project, since requried libraries will be downloaded by `maven`.

## Build and run steps
1. From the project's main directory `$XAP_SCALA_MASTER/example/gs-openspaces-scala-example` run command `mvn clean package` - necessary JAR files to deploy on a grid will be created.
2. Start XAP Grid Service by running command: `$GS_HOME/bin/gs-agent.sh`
3. Deploy the project on the grid (from `$XAP_SCALA_MASTER/example/gs-openspaces-scala-example`): `mvn os:deploy -Dgroups=$LOOKUPGROUPS`.

# <a name="used_xap_scala_features"/>Used XAP Scala features

## Constructor based properties

`Common` module defines space classes used by other modules. Please note, that the classes are written in Scala, and are used in other Scala and Java modules as well. This is caused by the fact that all of them are translated to a common code (bytecode) and therefore, can be used interchangeably.

Sometimes, having immutable state is very desired feature. This requirement is covered in XAP Scala by classes that use constructor based properties - in case of the `common` module it is the `Verification` class. It is written only once to the `Space` and never changed (eventually instance can be removed), because the goal of a single object is to remember appearance of a certain, unchangeable:

{% highlight scala %}
case class Verification @SpaceClassConstructor() (
  @BeanProperty
  @SpaceId
  id: String,

  @BeanProperty
  dataId: String) extends scala.Serializable {

  override def toString: String = s"id[$id] dataId[$dataId]"
}
{%endhighlight%}

The other class (`Data`) has been rewritten to Scala. However, its behavior has not been modified (apart from a adding new field needed by the `verifier` module):

{% highlight scala %}
case class Data (
  @BeanProperty @SpaceId(autoGenerate = true) var id: String = null,
  @BeanProperty @SpaceRouting @SpaceProperty(nullValue = "-1") var `type`: Long = -1,
  @BeanProperty var rawData: String = null,
  @BeanProperty var data: String = null,
  @BooleanBeanProperty var processed: Boolean = false,
  @BooleanBeanProperty var verified: Boolean = false) {

  def this(`type`: Long, rawData: String) = this(null, `type`, rawData, null, false, false)

  def this() = this(-1, null)

  override def toString: String = s"id[${id}] type[${`type`}] rawData[${rawData}] data[${data}] processed[${processed}] verified[${verified}]"
}
{%endhighlight%}

## Predicate based queries

The `verifier` module extends the pipeline presented in the baseline project (the one created by the `OpenSpaces Maven plugin`). `Verifier` picks up processed `Data` instances and tries to verify them. The objects that pass the verification process are then modified (`verified` set to `true`) and saved along with a new, immutable `Verification` object. The objects that failed during verification process are removed from the space. The `verifier` uses the new feature - predicate based queries - to access the space in a more readable and natural way (especially for functional languages such as Scala):

{% highlight scala %}
@GigaSpaceContext private var gigaSpace: GigaSpace = _ // injected
// ...

// data instances to process further are obtained in the following way
val unverifiedData = gigaSpace.predicate.readMultiple { data: Data => data.processed == true && data.verified == false }
{%endhighlight%}

Pu.xml contains a standard description of gigaSpace:

{% highlight xml %}
...
<os-core:giga-space-context/>

<os-core:space id="space" url="jini://*/*/space" />

<os-core:giga-space id="gigaSpace" space="space"/>
...
{%endhighlight%}

Please note that gigaSpace from the code above is an instance of ScalaEnhancedGigaSpaceWrapper - a wrapper around GigaSpace introduced in XAP Scala.

# <a name="building_scala_mixed_modules"/>Building Scala and mixed Java/Scala modules

The build configuration in Scala or Java/Scala modules is almost as simple in case of pure Java modules.

## Scala module

The `common` module is a pure Scala module. The `maven-compiler-plugin` has been replaced by `scala-maven-plugin`. The build configuration from the `pom.xml` for the `common` has the following form:

{% highlight xml %}
<build>
    <sourceDirectory>src/main/scala</sourceDirectory>
    <plugins>
        <plugin>
            <groupId>net.alchim31.maven</groupId>
            <artifactId>scala-maven-plugin</artifactId>
            <version>3.2.0</version>
            <executions>
                <execution>
                    <goals>
                        <goal>compile</goal>
                        <goal>testCompile</goal>
                    </goals>
                </execution>
            </executions>
            <configuration>
                <scalaCompatVersion>${scalaBinaryVersion}</scalaCompatVersion>
            </configuration>
        </plugin>
    </plugins>
    <finalName>gs-openspaces-scala-example-common</finalName>
</build>
{%endhighlight%}
where `scalaBinaryVersion` is a property defined in a parent pom file (in this case it is `2.11`).

## Java-Scala module

The `verifier` module is a mixed Java-Scala module, where Scala classes call Java classes. This configuration can be used when a separate task is implemented in Java and it only needs to be called from other parts of application. In case of this project, Java module is simulated by `VerifierEngine` class and, for ease of use, it is executed by Scala `verifier`.

In such a configuration, Scala compiler has to 'somehow' reach Java compiled classes. This is where a `build-helper-maven-plugin` is used - it adds Java classes to the source, then they are compiled and finally Scala compiler uses them during Scala code compilation. The build configuration of the `verifier` module is as follows:

{% highlight xml %}
<build>
    <sourceDirectory>src/main/scala</sourceDirectory>

    <plugins>
        <plugin>
            <groupId>org.codehaus.mojo</groupId>
            <artifactId>build-helper-maven-plugin</artifactId>
            <version>1.4</version>
            <executions>
                <execution>
                    <id>add-java-source</id>
                    <phase>generate-sources</phase>
                    <goals>
                        <goal>add-source</goal>
                    </goals>
                    <configuration>
                        <sources>
                            <source>${basedir}/src/main/java</source>
                        </sources>
                    </configuration>
                </execution>
            </executions>
        </plugin>
        <plugin>
            <groupId>net.alchim31.maven</groupId>
            <artifactId>scala-maven-plugin</artifactId>
            <version>3.2.0</version>
            <executions>
                <execution>
                    <goals>
                        <goal>compile</goal>
                        <goal>testCompile</goal>
                    </goals>
                </execution>
            </executions>
            <configuration>
                <scalaCompatVersion>${scalaBinaryVersion}</scalaCompatVersion>
            </configuration>
        </plugin>
    </plugins>
</build>
{%endhighlight%}