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
By default, Tomcat doesn't symlinking within webapps, so we need to manually allow this. In $TOMCAT_HOME/conf/Catalina/localhost, create orbeon.xml and paste the following:

    <Context path="/orbeon" docBase="c:/Program Files/Apache Software Foundation/Tomcat 8.0/webapps/orbeon.war" allowLinking="true"/>
    
Change the docBase path as necessary.

#### 3b. Configure Orbeon Properties ####
We need to make a minor configuration to Orbeon so that it uses the default, plain theme so that the Bootstrap-based CSS inherent to the AEW editor takes precedence.

 *  Navigate to $TOMCAT_HOME/webapps/orbeon/WEB-INF/resources/config/
 *  Rename *properties-local.xml.template* to *properties-local.xml* and insert within &lt;properties&gt;
    `&lt;property as="xs:anyURI" name="oxf.epilogue.theme" value="oxf:/config/theme-plain.xsl"/&gt;`
 *  Tomcat may need to be restarted for these changes to take effect.

### 4. Install and Configure Git ###
Follow platform specific instructions for intalling and configuring Git. There is a Github for Windows application. It should be configured to log in through an AEW administrator account (yet to be created) for deploying to the server.

### 5. Clone Github Repositories ###
  * Clone nwda-editor into $TOMCAT_HOME/webapps/orbeon/WEB-INF/resources/apps, calling it 'nwda'
  * Clone the repository_records someplace, e.g. D:\www.
  * Edit config.xml in the nwda app, updating the file\_path with the correct path to repository\_records. 
