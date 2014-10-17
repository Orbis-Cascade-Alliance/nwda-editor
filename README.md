Archives Engine West (AEW) Repository Metadata Editor
=====================================================

This is the Github repository for the Repository Metadata Editor for Archives Engine West. It is an [XForms](http://en.wikipedia.org/wiki/XForms) application that runs in the Java-based [Orbeon](http://www.orbeon.com) XForms processor, within the Apache Tomcat servlet container. Other Java servlet containers may be used.

Installation
------------
The following instructions are generic and apply to all platforms (Windows, Linux, OS X). Please see application-specific documentation for more thorough instructions for the particular platform.

### 1. Install Java JDK ###
Download and install the latest Java JDK from Oracle. On most modern Linux systems, it is available through the software repository (yum or aptitude). The open source openjdk is also functional.

### 2. Install Apache Tomcat ###
Download and install the latest stable version of Apache Tomcat. On Windows, execute the downloadable *.exe file and run Tomcat as a service. In Linux systems, Tomcat is available through the repository and will automatically be configured to run as a service.

#### 2a. Increase heap space ####
Orbeon will run with 512MB of heap space, but ideally it requires 1 GB. Nevertheless, this is greater than the default Java configuration. See the Orbeon [documentation](http://wiki.orbeon.com/forms/doc/developer-guide/admin/installing#TOC-Java-virtual-machine-configuration) for recommendations for configuring the virtual machine.

### 3. Download and deploy Orbeon ###
Go to the Orbeon [download page](http://www.orbeon.com/download) and download the current version of the free and open source Community Edition. From the zip file, extract orbeon.war and deploy the application. This can be achieved by using the Tomcat manager, if available, or by placing the WAR file into $TOMCAT_HOME/webapps.

#### 3a. Enable symlinking in Tomcat ####

 *Note: Skip this step for Tomcat8. Symlinking is enabled differently.*

By default, Tomcat doesn't symlinking within webapps, so we need to manually allow this. In $TOMCAT_HOME/conf/Catalina/localhost, create orbeon.xml and paste the following:

    <Context path="/orbeon" docBase="c:/Program Files/Apache Software Foundation/Tomcat 8.0/webapps/orbeon.war" allowLinking="true"/>
    
Change the docBase path as necessary.

#### 3b. Configure Orbeon Properties ####
We need to make a minor configuration to Orbeon so that it uses the default, plain theme so that the Bootstrap-based CSS inherent to the AEW editor takes precedence.

 *  Navigate to $TOMCAT_HOME/webapps/orbeon/WEB-INF/resources/config/
 *  Rename *properties-local.xml.template* to *properties-local.xml* and insert within &lt;properties&gt;
    `<property as="xs:anyURI" name="oxf.epilogue.theme" value="oxf:/config/theme-plain.xsl"/>`
 *  Tomcat may need to be restarted for these changes to take effect.

### 4. Install and Configure Git ###
Follow platform specific instructions for intalling and configuring Git. There is a Github for Windows application. It should be configured to log in through an AEW administrator account (yet to be created) for deploying to the server.

### 5. Clone Github Repositories ###
  * Clone nwda-editor into $TOMCAT_HOME/webapps/orbeon/WEB-INF/resources/apps, calling it 'nwda'
  * Clone the repository\_records into $TOMCAT_HOME/webapps/orbeon/WEB-INF/resources
  * The editor is now accessible by going to http://servername:8080/orbeon/nwda/edit/, and it will be able to save and load from the repository\_records using Orbeon's internal oxf: protocol.
  
### 6. Edit config.xml ###
In the nwda project folder, edit config.xml to update the &lt;tmp\_path&gt; and &lt;users\_path&gt;, if necessary.  On a Windows system, use forward slashes instead of back slashes.

The users_path is the path to the users.xml authentication file. When attempting to edit the RDF for a new user (i.e., when the RDF does not already exist on the disk), the RDF template will load, and the arch:Archive/@rdf:about will automatically be set to 'aew:{mainagencycode}'. The user must fill in the rest of the form; only a valid document will save.

The tmp_path is the path to the location where temporary session XML files are placed.
