# GI_19cSoftInstall

Summary
This playbook is for installing Oracle Grid Infrastructure 19c using ANsible playbook on Oracle Linux (7.5)

This assumes
1. You have setup your linux machine
2. Made a clone and changed the hostname
3. Assigned IP addresses to Public and private interfaces
4. Oracle Grid software in downloaded and staged to /u01/stage directory

Cluster Pre-install
1. Setup passwordless ssh between users
2. Do the Pre-checks. Ensure they pass successfully.
3. Setup Response File for silent installation. 
4. Start with Installation [As grid@Node1]
4. Root Script Execution
[Node 1 - /u02/app/oraInventory/orainstRoot.sh]
[Node 2 - /u02/app/oraInventory/orainstRoot.sh]
[Node 1 - /u02/app/19.3.0/grid/root.sh]
[Node 2 - /u02/app/19.3.0/grid/root.sh]
[Node 1 - Run Post Config]
5. Post verification
+++++++++++++++++++++++++++++++++++++++++++
SAMPLE RUN: 
+++++++++++++++++++++++++++++++++++++++++++

[root@oel75 ansible]# ansible-playbook oracleGInRAC19cR3.yml

PLAY [ora-x1,ora-x2] *********************************************************************************************

TASK [Gathering Facts] *******************************************************************************************
ok: [192.168.56.102]
ok: [192.168.56.103]

TASK [racgi19c_install : display pre installation of Oracle GI software message] *********************************
ok: [192.168.56.102] => {
    "msg": [
        "This playbook is for installing Oracle RAC GI software 19c , started at 2019-09-19T13:42:02Z:"
    ]
}
ok: [192.168.56.103] => {
    "msg": [
        "This playbook is for installing Oracle RAC GI software 19c , started at 2019-09-19T13:42:02Z:"
    ]
}

TASK [racgi19c_install : create required directories] ************************************************************
ok: [192.168.56.103] => (item=/u02/stage)
ok: [192.168.56.102] => (item=/u02/stage)
ok: [192.168.56.103] => (item=/u02/app/oraInventory)
ok: [192.168.56.102] => (item=/u02/app/oraInventory)
changed: [192.168.56.103] => (item=/u02/app/grid)
changed: [192.168.56.102] => (item=/u02/app/grid)
ok: [192.168.56.103] => (item=/u02/app/19.3.0/grid)
ok: [192.168.56.102] => (item=/u02/app/19.3.0/grid)

TASK [racgi19c_install : Install NTP for cluster] ****************************************************************
ok: [192.168.56.103]
ok: [192.168.56.102]

TASK [racgi19c_install : Ensure NTPD is running and enabled] *****************************************************
ok: [192.168.56.102]
ok: [192.168.56.103]

TASK [racgi19c_install : copy grid 19c grid software response file to the target database server] ****************
ok: [192.168.56.102] => (item=gridsetup19c.rsp)
ok: [192.168.56.103] => (item=gridsetup19c.rsp)
ok: [192.168.56.102] => (item=oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm)
ok: [192.168.56.103] => (item=oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm)

TASK [racgi19c_install : Unpack Oracle 19c GI Software] **********************************************************
changed: [192.168.56.102]

TASK [racgi19c_install : install cvu rpm from a local file] ******************************************************
changed: [192.168.56.102]

TASK [racgi19c_install : Transfer cvu file from ora-x1 to ora-x2] ************************************************
changed: [192.168.56.102 -> ora-x2]

TASK [racgi19c_install : install cvu rpm from a local file] ******************************************************
changed: [192.168.56.103]

TASK [racgi19c_install : Run cluster Verification Checks for CRS Installation] ***********************************
changed: [192.168.56.102]

TASK [racgi19c_install : Install Oracle 19c GI Software] *********************************************************
changed: [192.168.56.102]

TASK [racgi19c_install : Get the output log status] **************************************************************
changed: [192.168.56.102]

TASK [racgi19c_install : Output from Post GI Software Installation Check] ****************************************
ok: [192.168.56.102] => {
    "racgisoftinstall_log.stdout": "Successfully Setup Software with warning(s)."
}

TASK [racgi19c_install : Execute orainstroot.sh on the node1] ****************************************************
changed: [192.168.56.102]

TASK [racgi19c_install : Output from gisw_orainstroonode1] *******************************************************
ok: [192.168.56.102] => {
    "gisw_orainstroonode1.stdout_lines": [
        "Changing permissions of /u02/app/oraInventory.",
        "Adding read,write permissions for group.",
        "Removing read,write,execute permissions for world.",
        "",
        "Changing groupname of /u02/app/oraInventory to oinstall.",
        "The execution of the script is complete."
    ]
}

TASK [racgi19c_install : Execute orainstroot.sh on node2] ********************************************************
changed: [192.168.56.103]

TASK [racgi19c_install : Output from gisw_orainstroonode2] *******************************************************
ok: [192.168.56.103] => {
    "gisw_orainstroonode2.stdout_lines": [
        "Changing permissions of /u02/app/oraInventory.",
        "Adding read,write permissions for group.",
        "Removing read,write,execute permissions for world.",
        "",
        "Changing groupname of /u02/app/oraInventory to oinstall.",
        "The execution of the script is complete."
    ]
}

TASK [racgi19c_install : Execute root.sh on the first node] ******************************************************
changed: [192.168.56.102]

TASK [racgi19c_install : Get the logfile name on the first node] *************************************************
changed: [192.168.56.102]

TASK [racgi19c_install : Get the logfile information on the first node] ******************************************
changed: [192.168.56.102] => (item=logino.log)

TASK [racgi19c_install : debug] **********************************************************************************
ok: [192.168.56.102] => {
    "rootloginfon1.results[0].stdout_lines": [
        "Performing root user operation.",
        "",
        "The following environment variables are set as:",
        "    ORACLE_OWNER= grid",
        "    ORACLE_HOME=  /u02/app/19.3.0/grid",
        "   Copying dbhome to /usr/local/bin ...",
        "   Copying oraenv to /usr/local/bin ...",
        "   Copying coraenv to /usr/local/bin ...",
        "",
        "",
        "Creating /etc/oratab file...",
        "Entries will be added to the /etc/oratab file as needed by",
        "Database Configuration Assistant when a database is created",
        "Finished running generic part of root script.",
        "Now product-specific root actions will be performed.",
        "Relinking oracle with rac_on option",
        "Using configuration parameter file: /u02/app/19.3.0/grid/crs/install/crsconfig_params",
        "The log of current session can be found at:",
        "  /u02/app/grid/crsdata/ora-x1/crsconfig/rootcrs_ora-x1_2019-09-19_11-53-47PM.log",
        "2019/09/19 23:53:57 CLSRSC-594: Executing installation step 1 of 19: 'SetupTFA'.",
        "2019/09/19 23:53:57 CLSRSC-594: Executing installation step 2 of 19: 'ValidateEnv'.",
        "2019/09/19 23:53:57 CLSRSC-363: User ignored prerequisites during installation",
        "2019/09/19 23:53:58 CLSRSC-594: Executing installation step 3 of 19: 'CheckFirstNode'.",
        "2019/09/19 23:54:00 CLSRSC-594: Executing installation step 4 of 19: 'GenSiteGUIDs'.",
        "2019/09/19 23:54:01 CLSRSC-594: Executing installation step 5 of 19: 'SetupOSD'.",
        "2019/09/19 23:54:01 CLSRSC-594: Executing installation step 6 of 19: 'CheckCRSConfig'.",
        "2019/09/19 23:54:02 CLSRSC-594: Executing installation step 7 of 19: 'SetupLocalGPNP'.",
        "2019/09/19 23:54:46 CLSRSC-4002: Successfully installed Oracle Trace File Analyzer (TFA) Collector.",
        "2019/09/19 23:54:47 CLSRSC-594: Executing installation step 8 of 19: 'CreateRootCert'.",
        "2019/09/19 23:54:52 CLSRSC-594: Executing installation step 9 of 19: 'ConfigOLR'.",
        "2019/09/19 23:55:06 CLSRSC-594: Executing installation step 10 of 19: 'ConfigCHMOS'.",
        "2019/09/19 23:55:06 CLSRSC-594: Executing installation step 11 of 19: 'CreateOHASD'.",
        "2019/09/19 23:55:11 CLSRSC-594: Executing installation step 12 of 19: 'ConfigOHASD'.",
        "2019/09/19 23:55:12 CLSRSC-330: Adding Clusterware entries to file 'oracle-ohasd.service'",
        "2019/09/19 23:56:32 CLSRSC-594: Executing installation step 13 of 19: 'InstallAFD'.",
        "2019/09/19 23:56:39 CLSRSC-594: Executing installation step 14 of 19: 'InstallACFS'.",
        "2019/09/19 23:58:06 CLSRSC-594: Executing installation step 15 of 19: 'InstallKA'.",
        "2019/09/19 23:58:11 CLSRSC-594: Executing installation step 16 of 19: 'InitConfig'.",
        "",
        "ASM has been created and started successfully.",
        "",
        "[DBT-30001] Disk groups created successfully. Check /u02/app/grid/cfgtoollogs/asmca/asmca-190919PM115845.log for details.",
        "",
        "2019/09/19 23:59:45 CLSRSC-482: Running command: '/u02/app/19.3.0/grid/bin/ocrconfig -upgrade grid oinstall'",
        "CRS-4256: Updating the profile",
        "Successful addition of voting disk 7d0585e76fcd4fe1bf7f86bf646614a1.",
        "Successfully replaced voting disk group with +DATA.",
        "CRS-4256: Updating the profile",
        "CRS-4266: Voting file(s) successfully replaced",
        "##  STATE    File Universal Id                File Name Disk group",
        "--  -----    -----------------                --------- ---------",
        " 1. ONLINE   7d0585e76fcd4fe1bf7f86bf646614a1 (/dev/oracleasm/disks/ASM_DISK04) [DATA]",
        "Located 1 voting disk(s).",
        "2019/09/20 00:02:07 CLSRSC-594: Executing installation step 17 of 19: 'StartCluster'.",
        "2019/09/20 00:04:01 CLSRSC-343: Successfully started Oracle Clusterware stack",
        "2019/09/20 00:04:01 CLSRSC-594: Executing installation step 18 of 19: 'ConfigNode'.",
        "2019/09/20 00:08:03 CLSRSC-594: Executing installation step 19 of 19: 'PostConfig'.",
        "2019/09/20 00:09:11 CLSRSC-325: Configure Oracle Grid Infrastructure for a Cluster ... succeeded"
    ]
}

TASK [racgi19c_install : Execute root.sh on the second node] *****************************************************
changed: [192.168.56.103]

TASK [racgi19c_install : Get the logfile information on the second node] *****************************************
changed: [192.168.56.103]

TASK [racgi19c_install : Get the logfile information on the second node] *****************************************
changed: [192.168.56.103] => (item=logino.log)

TASK [racgi19c_install : debug] **********************************************************************************
ok: [192.168.56.103] => {
    "rootloginfon2.results[0].stdout_lines": [
        "Performing root user operation.",
        "",
        "The following environment variables are set as:",
        "    ORACLE_OWNER= grid",
        "    ORACLE_HOME=  /u02/app/19.3.0/grid",
        "   Copying dbhome to /usr/local/bin ...",
        "   Copying oraenv to /usr/local/bin ...",
        "   Copying coraenv to /usr/local/bin ...",
        "",
        "",
        "Creating /etc/oratab file...",
        "Entries will be added to the /etc/oratab file as needed by",
        "Database Configuration Assistant when a database is created",
        "Finished running generic part of root script.",
        "Now product-specific root actions will be performed.",
        "Relinking oracle with rac_on option",
        "Using configuration parameter file: /u02/app/19.3.0/grid/crs/install/crsconfig_params",
        "The log of current session can be found at:",
        "  /u02/app/grid/crsdata/ora-x2/crsconfig/rootcrs_ora-x2_2019-09-20_00-10-13AM.log",
        "2019/09/20 00:10:28 CLSRSC-594: Executing installation step 1 of 19: 'SetupTFA'.",
        "2019/09/20 00:10:28 CLSRSC-594: Executing installation step 2 of 19: 'ValidateEnv'.",
        "2019/09/20 00:10:28 CLSRSC-363: User ignored prerequisites during installation",
        "2019/09/20 00:10:28 CLSRSC-594: Executing installation step 3 of 19: 'CheckFirstNode'.",
        "2019/09/20 00:10:32 CLSRSC-594: Executing installation step 4 of 19: 'GenSiteGUIDs'.",
        "2019/09/20 00:10:32 CLSRSC-594: Executing installation step 5 of 19: 'SetupOSD'.",
        "2019/09/20 00:10:32 CLSRSC-594: Executing installation step 6 of 19: 'CheckCRSConfig'.",
        "2019/09/20 00:10:34 CLSRSC-594: Executing installation step 7 of 19: 'SetupLocalGPNP'.",
        "2019/09/20 00:10:38 CLSRSC-594: Executing installation step 8 of 19: 'CreateRootCert'.",
        "2019/09/20 00:10:38 CLSRSC-594: Executing installation step 9 of 19: 'ConfigOLR'.",
        "2019/09/20 00:10:56 CLSRSC-594: Executing installation step 10 of 19: 'ConfigCHMOS'.",
        "2019/09/20 00:10:57 CLSRSC-594: Executing installation step 11 of 19: 'CreateOHASD'.",
        "2019/09/20 00:11:02 CLSRSC-594: Executing installation step 12 of 19: 'ConfigOHASD'.",
        "2019/09/20 00:11:03 CLSRSC-330: Adding Clusterware entries to file 'oracle-ohasd.service'",
        "2019/09/20 00:11:32 CLSRSC-4002: Successfully installed Oracle Trace File Analyzer (TFA) Collector.",
        "2019/09/20 00:14:09 CLSRSC-594: Executing installation step 13 of 19: 'InstallAFD'.",
        "2019/09/20 00:14:13 CLSRSC-594: Executing installation step 14 of 19: 'InstallACFS'.",
        "2019/09/20 00:17:11 CLSRSC-594: Executing installation step 15 of 19: 'InstallKA'.",
        "2019/09/20 00:17:14 CLSRSC-594: Executing installation step 16 of 19: 'InitConfig'.",
        "2019/09/20 00:17:34 CLSRSC-594: Executing installation step 17 of 19: 'StartCluster'.",
        "2019/09/20 00:19:26 CLSRSC-343: Successfully started Oracle Clusterware stack",
        "2019/09/20 00:19:26 CLSRSC-594: Executing installation step 18 of 19: 'ConfigNode'.",
        "2019/09/20 00:20:18 CLSRSC-594: Executing installation step 19 of 19: 'PostConfig'.",
        "2019/09/20 00:20:44 CLSRSC-325: Configure Oracle Grid Infrastructure for a Cluster ... succeeded"
    ]
}

TASK [racgi19c_install : Install Oracle 19c GI ConfigTools in Silent Mode] ***************************************
changed: [192.168.56.102]

TASK [racgi19c_install : Get the logfile name ConfigTools] *******************************************************
changed: [192.168.56.102]

TASK [racgi19c_install : Get the logfile information for ConfigTools] ********************************************
changed: [192.168.56.102] => (item=logino.log)

TASK [racgi19c_install : debug] **********************************************************************************
ok: [192.168.56.102] => {
    "giexecfg.results[0].stdout_lines": [
        "****************************************************************************",
        "INFO: Oracle Universal Installer version is 12.2.0.7.0",
        "",
        "INFO: Environment Variables: ",
        "",
        "INFO: \tORACLE_HOME = /u02/app/19.3.0/grid",
        "",
        "INFO: \tPATH = /sbin:/bin:/usr/sbin:/usr/bin",
        "",
        "INFO: \tCLASSPATH = ",
        "",
        "INFO: Username:grid",
        "INFO: ",
        "=================================================================JVM PROPERTIES===========================================================",
        "oracle.installer.warningonremovefiles = true",
        "oracle.installer.removeHome = false",
        "file.encoding.pkg = sun.io",
        "oracle.installer.ignoreDiskLabel = false",
        "java.home = /u02/app/19.3.0/grid/jdk/jre",
        "actionable.validation.advisor.severity = FATAL",
        "autoConfigureVIP_helpid = S_HELP_AUTOCONFIGURE_VIP@oracle.sysman.oii.oiir.OiirRuntimeRes",
        "sun.font.fontmanager = sun.awt.X11FontManager",
        "oracle.installer.waitforcompletion = true",
        "java.endorsed.dirs = /u02/app/19.3.0/grid/jdk/jre/lib/endorsed",
        "oracle.installer.silent = true",
        "oracle.install.asm.util.asmtoolg.ASMTOOL_HOME = /u02/app/19.3.0/grid/bin",
        "oracle.installer.suppressedSource = false",
        "oracle.installer.rootshbackup = true",
        "oracle.installer.fastcopy = true",
        "sun.os.patch.level = unknown",
        "java.vendor.url = http://java.oracle.com/",
        "oracle.installer.acceptUntrustedCertificates = false",
        "java.version = 1.8.0_201",
        "oracle.installer.cleanup = false",
        "oracle.installer.suppressPostCopyScript = false",
        "oracle.installer.installAddOns = false",
        "oracle.installer.generateGUID = true",
        "oracle.installer.help = false",
        "oracle.srvm.formCluster = false",
        "oracle.install.commons.base.driver.common.SetupDriver = oracle.install.ivw.crs.driver.CRSImageSetupDriver",
        "oracle.installer.silentVariableValidation = false",
        "java.vendor.url.bug = http://bugreport.sun.com/bugreport/",
        "oracle.installer.oui_loc = /u02/app/19.3.0/grid/oui",
        "oracle.install.library.partition.diskmanager.ORAREMOTESERVICE_PATH = /u02/app/19.3.0/grid/bin",
        "oracle.installer.addNode = false",
        "user.name = grid",
        "sun.io.unicode.encoding = UnicodeLittle",
        "sun.jnu.encoding = UTF-8",
        "oracle.install.asm.util.kfod.PATH = /u02/app/19.3.0/grid/bin",
        "java.runtime.name = Java(TM) SE Runtime Environment",
        "oracle.installer.printmemory = false",
        "oracle.installer.performRemoteCopyInAPIMode = false",
        "oracle.installer.nobootStrap = false",
        "oracle.installer.dynamicLoadOnPrereqRetry = true",
        "oracle.installer.ntw32FoldersActions = true",
        "oracle.installer.preCloneSetup = false",
        "oracle.installer.removeallfiles = false",
        "java.specification.name = Java Platform API Specification",
        "oracle.installer.exitOnPrereqFailure = false",
        "user.timezone = Australia/Sydney",
        "path.separator = :",
        "file.encoding = UTF-8",
        "application.commandline.validateForMandatoryDependentArgs = true",
        "oracle.installer.ignorePatchConflicts = false",
        "sun.java.command = oracle.install.ivw.crs.driver.CRSConfigWizard -printtime ORACLE_HOME=/u02/app/19.3.0/grid -silent -executeConfigTools -waitforcompletion -skipStackCheck -responseFile /u02/stage/gridsetup19c.rsp -all",
        "oracle.installer.continueOnAllChecksPass = false",
        "oracle.installer.executeSysPrereqs = false",
        "oracle.installer.forceDeinstall = false",
        "oracle.installer.timestamp = 2019-09-20_00-20-51AM",
        "oracle.installer.detachHome = false",
        "java.io.tmpdir = /tmp/GridSetupActions2019-09-20_00-20-51AM",
        "oracle.installer.scratchPath = /u02/app/19.3.0/grid/inventory/Scripts",
        "user.language = en",
        "oracle.installer.skipACLSetting = false",
        "line.separator = ",
        "",
        "oracle.installer.enableRollingUpgrade = false",
        "oracle.installer.deinstall = false",
        "oracle.installer.rootshcumulative = false",
        "oracle.installer.gridConfig = true",
        "oracle.installer.defaultHomeName = false",
        "oracle.installer.ignoreSharedInventory = true",
        "java.vm.info = mixed mode",
        "java.vm.specification.name = Java Virtual Machine Specification",
        "oracle.installer.cleanUpOnExit = true",
        "oracle.installer.tempLogDir = /tmp/GridSetupActions2019-09-20_00-20-51AM",
        "exitOnMakeFailure_helpid = S_HELP_OPTION_EXITONMAKEFAILURE@oracle.sysman.oii.oiir.OiirRuntimeRes",
        "oracle.installer.summary_expand_nodes = Global,Langs,Space,NewInstalls,Upgrades,Reinstalls,Deinstalls,NewLangs",
        "oracle.installer.upgradeOUI = false",
        "oracle.install.commons.base.util.OracleServiceRegistry = oracle.install.driver.oui.OUIOracleServiceRegistry",
        "java.awt.printerjob = sun.print.PSPrinterJob",
        "oracle.installer.install.showproductname = true",
        "oracle.installer.showVariables = false",
        "oracle.installer.remoteActions = true",
        "oracle.installer.supportBinaryInventory = false",
        "OUI_TEMP_OB = /u02/app/oraInventory/logs/GridSetupActions2019-09-20_00-20-51AM/temp_ob",
        "oracle.installer.console = true",
        "oracle.installer.welcome = true",
        "os.name = Linux",
        "oracle.installer.exitOnVarValidationFailure = false",
        "java.specification.vendor = Oracle Corporation",
        "java.vm.name = Java HotSpot(TM) 64-Bit Server VM",
        "oracle.installer.updateNodeList = false",
        "oracle.installer.suppressPreCopyScript = false",
        "java.library.path = /u02/app/19.3.0/grid/lib:/u02/app/19.3.0/grid/oui/lib/linux64:/u02/app/19.3.0/grid/bin:/usr/java/packages/lib/amd64:/usr/lib64:/lib64:/lib:/usr/lib",
        "SRVM_SAVE_CACHE = true",
        "java.class.version = 52.0",
        "oracle.install.commons.net.support.SSHSupportManager = oracle.install.commons.net.support.DefaultSSHSupportManager",
        "oracle.installer.printdiskusage = false",
        "oracle.installer.copy = true",
        "oracle.installer.config = true",
        "oracle.installer.allDepHomes = false",
        "application.commandline.currentContextId = GridSetup",
        "oracle.installer.record = false",
        "oracle.installer.remote = false",
        "oracle.installer.install.showinstalledproducts = true",
        "oracle.installer.fileActions = true",
        "sun.boot.library.path = /u02/app/19.3.0/grid/jdk/jre/lib/amd64",
        "example_ids = S_HELP_VARIABLE_DEFINITION,S_HELP_SESSION_VARIABLE_TITLE,S_HELP_SESSION_EX1,S_HELP_SESSION_EX2,S_HELP_SESSION_VARIABLE_LOOKUP,S_HELP_COMPONENT_VARIABLE_TITLE,S_HELP_COMPONENT_EX1,S_HELP_COMPONENT_EX2,S_HELP_COMPONENT_VARIABLE_LOOKUP",
        "sun.management.compiler = HotSpot 64-Bit Tiered Compilers",
        "java.awt.graphicsenv = sun.awt.X11GraphicsEnvironment",
        "oracle.installer.install.showproductversion = true",
        "oracle.installer.wait = true",
        "oracle.installer.printtimeverbose = false",
        "oracle.installer.clusterEnabled = true",
        "oracle.install.asm.util.kfod.KFOD_ORACLE_HOME = /u02/app/19.3.0/grid",
        "oracle.installer.depHomesOnly = false",
        "oracle.installer.configWizard = true",
        "oracle.installer.clone = false",
        "oracle.installer.removeAllPatches = false",
        "java.vm.specification.version = 1.8",
        "oracle.installer.installUpdates = false",
        "awt.toolkit = sun.awt.X11.XToolkit",
        "oracle.installer.remotecopy.standalone = true",
        "sun.cpu.isalist = ",
        "oracle.installer.entryPoint = oracle.crs_Complete_cluster_install",
        "java.ext.dirs = /u02/app/19.3.0/grid/jdk/jre/lib/ext:/usr/java/packages/lib/ext",
        "oracle.installer.forceClone = false",
        "os.version = 4.1.12-124.16.4.el7uek.x86_64",
        "oracle.installer.appendConfigCommands = false",
        "application.commandline.toolName = gridSetup.sh",
        "oracle.installer.backupInventory = true",
        "user.home = /home/grid",
        "oracle.installer.testForAutoUpdates = false",
        "java.vm.vendor = Oracle Corporation",
        "oracle.installer.h = false",
        "oracle.installer.skipLogsToHome = false",
        "oracle.installer.exitOnStopInstall = false",
        "oracle.installer.splash = true",
        "oracle.installer.putTimestamp = false",
        "oracle.installer.mandatorySetup = false",
        "user.dir = /u02/app/19.3.0/grid",
        "oracle.installer.setCustomNodelist = false",
        "oracle.installer.printtime = true",
        "oracle.installer.executeRemotePrereqs = false",
        "oracle.installer.updateNodeListEx = false",
        "oracle.installer.exitonback = false",
        "oracle.installer.oh_admin_acl = false",
        "oracle.installer.responseFile = /u02/stage/gridsetup19c.rsp",
        "oracle.install.cvu.prereq_xml_loc = /u02/app/19.3.0/grid/cv/cvdata/cvu_prereq.xml",
        "sun.cpu.endian = little",
        "oracle.installer.sessionType = Install",
        "oracle.sysman.prov.PathsPropertiesLoc = /u02/app/19.3.0/grid/oui/prov/resources",
        "oracle.installer.link = true",
        "oracle.installer.library_loc = /u02/app/19.3.0/grid/oui/lib/linux64",
        "java.vm.version = 25.201-b09",
        "ORACLE_HOME = /u02/app/19.3.0/grid",
        "java.class.path = /u02/app/19.3.0/grid/install/jlib/installcommons_1.0.0b.jar:/u02/app/19.3.0/grid/install/jlib/instcommon.jar:/u02/app/19.3.0/grid/install/jlib/instcrs.jar:/u02/app/19.3.0/grid/install/jlib/pilot_1.0.0b.jar:/u02/app/19.3.0/grid/install/jlib/instdb.jar:/u02/app/19.3.0/grid/install/jlib/instclient.jar:/u02/app/19.3.0/grid/install/jlib/emCoreConsole.jar:/u02/app/19.3.0/grid/jlib/cvu.jar:/u02/app/19.3.0/grid/jlib/srvmhas.jar:/u02/app/19.3.0/grid/jlib/srvmasm.jar:/u02/app/19.3.0/grid/jlib/gns.jar:/u02/app/19.3.0/grid/jlib/srvm.jar:/u02/app/19.3.0/grid/jlib/oraclepki.jar:/u02/app/19.3.0/grid/jlib/mgmtca.jar:/u02/app/19.3.0/grid/jlib/mgmtua.jar:/u02/app/19.3.0/grid/jlib/clscred.jar:/u02/app/19.3.0/grid/jlib/oracle.dbtools-common.jar:/u02/app/19.3.0/grid/jlib/wsclient_extended.jar:/u02/app/19.3.0/grid/jlib/adf-share-ca.jar:/u02/app/19.3.0/grid/jlib/jmxspi.jar:/u02/app/19.3.0/grid/jlib/emca.jar:/u02/app/19.3.0/grid/jlib/entityManager_proxy.jar:/u02/app/19.3.0/grid/jlib/javax.security.jacc_1.0.0.0_1-1.jar:/u02/app/19.3.0/grid/jlib/orai18n-mapping.jar:/u02/app/19.3.0/grid/jlib/orai18n-utility.jar:/u02/app/19.3.0/grid/jlib/orai18n-translation.jar:/u02/app/19.3.0/grid/jlib/jwc-cred.jar:/u02/app/19.3.0/grid/jdbc/lib/ojdbc8.jar:/u02/app/19.3.0/grid/OPatch/jlib/opatchsdk.jar:/u02/app/19.3.0/grid/OPatch/jlib/opatch.jar:/u02/app/19.3.0/grid/oui/jlib/OraPrereqChecks.jar:/u02/app/19.3.0/grid/oui/jlib/prov_fixup.jar:/u02/app/19.3.0/grid/oui/jlib/ssh.jar:/u02/app/19.3.0/grid/oui/jlib/jsch.jar:/u02/app/19.3.0/grid/oui/jlib/remoteinterfaces.jar:/u02/app/19.3.0/grid/oui/jlib/OraPrereq.jar:/u02/app/19.3.0/grid/oui/jlib/com.oracle.glcm.patch.opatch-common-api-schema_13.9.3.0.jar:/u02/app/19.3.0/grid/oui/jlib/share.jar:/u02/app/19.3.0/grid/oui/jlib/OraSuiteInstaller.jar:/u02/app/19.3.0/grid/oui/jlib/InstHelp_pt_BR.jar:/u02/app/19.3.0/grid/oui/jlib/InstHelp_fr.jar:/u02/app/19.3.0/grid/oui/jlib/InstHelp_ja.jar:/u02/app/19.3.0/grid/oui/jlib/swingaccess.jar:/u02/app/19.3.0/grid/oui/jlib/ewt3.jar:/u02/app/19.3.0/grid/oui/jlib/InstHelp_es.jar:/u02/app/19.3.0/grid/oui/jlib/xml.jar:/u02/app/19.3.0/grid/oui/jlib/OraInstallerNet.jar:/u02/app/19.3.0/grid/oui/jlib/com.oracle.glcm.patch.opatch-common-api-interfaces_13.9.3.0.jar:/u02/app/19.3.0/grid/oui/jlib/jewt4.jar:/u02/app/19.3.0/grid/oui/jlib/emCfg.jar:/u02/app/19.3.0/grid/oui/jlib/oui.jar:/u02/app/19.3.0/grid/oui/jlib/filesList.jar:/u02/app/19.3.0/grid/oui/jlib/InstHelp.jar:/u02/app/19.3.0/grid/oui/jlib/orai18n-collation.jar:/u02/app/19.3.0/grid/oui/jlib/ohj.jar:/u02/app/19.3.0/grid/oui/jlib/InstHelp_zh_CN.jar:/u02/app/19.3.0/grid/oui/jlib/com.oracle.glcm.patch.opatch-common-api_13.9.3.0.jar:/u02/app/19.3.0/grid/oui/jlib/InstHelp_it.jar:/u02/app/19.3.0/grid/oui/jlib/InstHelp_zh_TW.jar:/u02/app/19.3.0/grid/oui/jlib/classes12.jar:/u02/app/19.3.0/grid/oui/jlib/xmlparserv2.jar:/u02/app/19.3.0/grid/oui/jlib/http_client.jar:/u02/app/19.3.0/grid/oui/jlib/OraCheckPoint.jar:/u02/app/19.3.0/grid/oui/jlib/oneclick.jar:/u02/app/19.3.0/grid/oui/jlib/InstHelp_de.jar:/u02/app/19.3.0/grid/oui/jlib/InstImages.jar:/u02/app/19.3.0/grid/oui/jlib/ojmisc.jar:/u02/app/19.3.0/grid/oui/jlib/oracle_ice.jar:/u02/app/19.3.0/grid/oui/jlib/InstHelp_ko.jar:/u02/app/19.3.0/grid/oui/jlib/help-share.jar:/u02/app/19.3.0/grid/oui/jlib/OraInstaller.jar:/u02/app/19.3.0/grid/oui/jlib/ewt3-swingaccess.jar",
        "oracle.installer.oneclick = false",
        "oracle.installer.ouiApiMode = true",
        "os.arch = amd64",
        "oracle.installer.attachHome = false",
        "oracle.installer.addLangs = false",
        "oracle.installer.ignoreDiskWarning = false",
        "oracle.installer.createLinkBackup = true",
        "oracle.installer.compsdeinstall = true",
        "oracle.installer.homepermissioncheck = true",
        "oracle.installer.force = false",
        "oracle.installer.cfs = false",
        "oracle.installer.repeat = true",
        "oracle.installer.doNotUpdateNodeList = false",
        "sun.java.launcher = SUN_STANDARD",
        "CV_HOME = /u02/app/19.3.0/grid",
        "java.vm.specification.vendor = Oracle Corporation",
        "oracle.installer.showLoadProgress = false",
        "oracle.installer.defaultifyLanguages = false",
        "file.separator = /",
        "oracle.installer.ignorePreReq = false",
        "CVU_OS_SETTINGS = SHELL_NOFILE_SOFT_LIMIT:131072,SHELL_STACK_SOFT_LIMIT:10240,SHELL_UMASK:0022",
        "java.runtime.version = 1.8.0_201-b09",
        "sun.boot.class.path = /u02/app/19.3.0/grid/jdk/jre/lib/resources.jar:/u02/app/19.3.0/grid/jdk/jre/lib/rt.jar:/u02/app/19.3.0/grid/jdk/jre/lib/sunrsasign.jar:/u02/app/19.3.0/grid/jdk/jre/lib/jsse.jar:/u02/app/19.3.0/grid/jdk/jre/lib/jce.jar:/u02/app/19.3.0/grid/jdk/jre/lib/charsets.jar:/u02/app/19.3.0/grid/jdk/jre/lib/jfr.jar:/u02/app/19.3.0/grid/jdk/jre/classes",
        "java.security.policy = jar:file:/u02/app/19.3.0/grid/install/jlib/installcommons_1.0.0b.jar!/oracle/install/commons/base/driver/common/installer.policy",
        "oracle.installer.relink = false",
        "user.country = US",
        "oracle.installer.ignoreSysPrereqs = false",
        "oracle.installer.debug = false",
        "oracle.installer.remoteInvocation = false",
        "oracle.installer.local = false",
        "oracle.installer.useExistingInventory = true",
        "oracle.installer.clusterSwitch = false",
        "oracle.installer.background = true",
        "java.vendor = Oracle Corporation",
        "oracle.installer.logCopyRequired = false",
        "java.specification.version = 1.8",
        "oracle.installer.logPrefix = gridSetupActions",
        "sun.arch.data.model = 64",
        "==========================================================================================================================================",
        "INFO: Creating a new Install area Control for this inventory session with new  access level  2",
        "INFO: Install area Control created with access level  2",
        "INFO: Initializing Logs dir to - /u02/app/oraInventory/logs",
        "INFO: Ending the inventory Session ",
        "INFO: config-context initialized",
        "INFO: ",
        " The Runconfig command constructed is /u02/app/19.3.0/grid/oui/bin/runConfig.sh ORACLE_HOME=/u02/app/19.3.0/grid MODE=perform ACTION=configure RERUN=true $*",
        "INFO: Since the option is to overwrite the existing /u02/app/19.3.0/grid/cfgtoollogs/configToolAllCommands file, backing it up",
        "INFO: The backed up file name is /u02/app/19.3.0/grid/cfgtoollogs/configToolAllCommands.bak",
        "INFO: Done processing command line arguments",
        "INFO: Setting variable 'ORACLE_HOME' to '/u02/app/19.3.0/grid'. Received the value from the command line.",
        "INFO: Setting variable 'CLUSTER_NEW_NODES' to ''. Received the value from the command line.",
        "INFO: Setting variable 'NODES_TO_SET' to 'ora-x1,ora-x2'. Received the value from the command line.",
        "INFO: Setting variable 'CRS' to 'true'. Received the value from the command line.",
        "INFO: Done creating session context and setting session variables as per command line",
        "INFO: Creating a new Install area Control for this inventory session with new  access level  1",
        "INFO: Install area Control created with access level  1",
        "****************************************************************************",
        "INFO: Oracle Universal Installer version is 12.2.0.7.0",
        "",
        "INFO: Environment Variables: ",
        "",
        "INFO: \tORACLE_HOME = /u02/app/19.3.0/grid",
        "",
        "INFO: \tPATH = /sbin:/bin:/usr/sbin:/usr/bin",
        "",
        "INFO: \tCLASSPATH = ",
        "",
        "INFO: Username:grid",
        "INFO: ",
        "=================================================================JVM PROPERTIES===========================================================",
        "oracle.installer.warningonremovefiles = true",
        "oracle.installer.removeHome = false",
        "file.encoding.pkg = sun.io",
        "oracle.installer.ignoreDiskLabel = false",
        "java.home = /u02/app/19.3.0/grid/jdk/jre",
        "HOME_LOCATION_API = /u02/app/19.3.0/grid",
        "actionable.validation.advisor.severity = FATAL",
        "autoConfigureVIP_helpid = S_HELP_AUTOCONFIGURE_VIP@oracle.sysman.oii.oiir.OiirRuntimeRes",
        "sun.font.fontmanager = sun.awt.X11FontManager",
        "oracle.installer.waitforcompletion = true",
        "java.endorsed.dirs = /u02/app/19.3.0/grid/jdk/jre/lib/endorsed",
        "oracle.installer.silent = true",
        "oracle.install.asm.util.asmtoolg.ASMTOOL_HOME = /u02/app/19.3.0/grid/bin",
        "oracle.installer.suppressedSource = false",
        "oracle.installer.rootshbackup = true",
        "oracle.installer.fastcopy = true",
        "sun.os.patch.level = unknown",
        "java.vendor.url = http://java.oracle.com/",
        "oracle.installer.acceptUntrustedCertificates = false",
        "java.version = 1.8.0_201",
        "oracle.installer.cleanup = false",
        "oracle.installer.suppressPostCopyScript = false",
        "oracle.installer.installAddOns = false",
        "oracle.installer.generateGUID = true",
        "oracle.installer.help = false",
        "oracle.srvm.formCluster = false",
        "oracle.install.commons.base.driver.common.SetupDriver = oracle.install.ivw.crs.driver.CRSImageSetupDriver",
        "oracle.installer.silentVariableValidation = false",
        "java.vendor.url.bug = http://bugreport.sun.com/bugreport/",
        "oracle.installer.oui_loc = /u02/app/19.3.0/grid/oui",
        "java.protocol.handler.pkgs = |oracle.sysman.oii",
        "oracle.install.library.partition.diskmanager.ORAREMOTESERVICE_PATH = /u02/app/19.3.0/grid/bin",
        "oracle.installer.addNode = false",
        "user.name = grid",
        "sun.io.unicode.encoding = UnicodeLittle",
        "sun.jnu.encoding = UTF-8",
        "oracle.install.asm.util.kfod.PATH = /u02/app/19.3.0/grid/bin",
        "java.runtime.name = Java(TM) SE Runtime Environment",
        "oracle.installer.printmemory = false",
        "oracle.installer.performRemoteCopyInAPIMode = false",
        "DO_NOT_UPDATE_LOCAL_NODE_LIST = false",
        "oracle.installer.nobootStrap = false",
        "oracle.installer.dynamicLoadOnPrereqRetry = true",
        "oracle.installer.ntw32FoldersActions = true",
        "oracle.installer.preCloneSetup = false",
        "oracle.installer.removeallfiles = false",
        "java.specification.name = Java Platform API Specification",
        "oracle.installer.exitOnPrereqFailure = false",
        "user.timezone = Australia/Sydney",
        "path.separator = :",
        "file.encoding = UTF-8",
        "application.commandline.validateForMandatoryDependentArgs = true",
        "oracle.installer.ignorePatchConflicts = false",
        "sun.java.command = oracle.install.ivw.crs.driver.CRSConfigWizard -printtime ORACLE_HOME=/u02/app/19.3.0/grid -silent -executeConfigTools -waitforcompletion -skipStackCheck -responseFile /u02/stage/gridsetup19c.rsp -all",
        "oracle.installer.continueOnAllChecksPass = false",
        "oracle.installer.executeSysPrereqs = false",
        "oracle.installer.forceDeinstall = false",
        "oracle.installer.timestamp = 2019-09-20_00-20-51AM",
        "oracle.installer.detachHome = false",
        "java.io.tmpdir = /tmp/GridSetupActions2019-09-20_00-20-51AM",
        "oracle.installer.scratchPath = /tmp/GridSetupActions2019-09-20_00-20-51AM",
        "user.language = en",
        "oracle.installer.skipACLSetting = false",
        "line.separator = ",
        "",
        "oracle.installer.enableRollingUpgrade = false",
        "oracle.installer.deinstall = false",
        "oracle.installer.rootshcumulative = false",
        "oracle.installer.gridConfig = true",
        "oracle.installer.defaultHomeName = false",
        "oracle.installer.ignoreSharedInventory = true",
        "java.vm.info = mixed mode",
        "java.vm.specification.name = Java Virtual Machine Specification",
        "oracle.installer.cleanUpOnExit = true",
        "oracle.installer.tempLogDir = /tmp/GridSetupActions2019-09-20_00-20-51AM",
        "oracle.installer.font = SansSerif",
        "exitOnMakeFailure_helpid = S_HELP_OPTION_EXITONMAKEFAILURE@oracle.sysman.oii.oiir.OiirRuntimeRes",
        "oracle.installer.summary_expand_nodes = Global,Langs,Space,NewInstalls,Upgrades,Reinstalls,Deinstalls,NewLangs",
        "oracle.installer.upgradeOUI = false",
        "oracle.install.commons.base.util.OracleServiceRegistry = oracle.install.driver.oui.OUIOracleServiceRegistry",
        "java.awt.printerjob = sun.print.PSPrinterJob",
        "oracle.installer.install.showproductname = true",
        "oracle.installer.showVariables = false",
        "oracle.installer.remoteActions = true",
        "oracle.installer.supportBinaryInventory = false",
        "OUI_TEMP_OB = /u02/app/oraInventory/logs/GridSetupActions2019-09-20_00-20-51AM/temp_ob",
        "oracle.installer.console = true",
        "oracle.installer.welcome = true",
        "os.name = Linux",
        "oracle.installer.exitOnVarValidationFailure = false",
        "java.specification.vendor = Oracle Corporation",
        "java.vm.name = Java HotSpot(TM) 64-Bit Server VM",
        "oracle.installer.updateNodeList = true",
        "oracle.installer.suppressPreCopyScript = false",
        "java.library.path = /u02/app/19.3.0/grid/lib:/u02/app/19.3.0/grid/oui/lib/linux64:/u02/app/19.3.0/grid/bin:/usr/java/packages/lib/amd64:/usr/lib64:/lib64:/lib:/usr/lib",
        "SRVM_SAVE_CACHE = true",
        "java.class.version = 52.0",
        "oracle.install.commons.net.support.SSHSupportManager = oracle.install.commons.net.support.DefaultSSHSupportManager",
        "oracle.installer.printdiskusage = false",
        "oracle.installer.jre_loc = /u02/app/19.3.0/grid/jdk/jre",
        "oracle.installer.copy = true",
        "oracle.installer.config = true",
        "oracle.installer.allDepHomes = false",
        "application.commandline.currentContextId = GridSetup",
        "oracle.installer.record = false",
        "oracle.installer.remote = false",
        "oracle.installer.install.showinstalledproducts = true",
        "oracle.installer.fileActions = true",
        "sun.boot.library.path = /u02/app/19.3.0/grid/jdk/jre/lib/amd64",
        "example_ids = S_HELP_VARIABLE_DEFINITION,S_HELP_SESSION_VARIABLE_TITLE,S_HELP_SESSION_EX1,S_HELP_SESSION_EX2,S_HELP_SESSION_VARIABLE_LOOKUP,S_HELP_COMPONENT_VARIABLE_TITLE,S_HELP_COMPONENT_EX1,S_HELP_COMPONENT_EX2,S_HELP_COMPONENT_VARIABLE_LOOKUP",
        "sun.management.compiler = HotSpot 64-Bit Tiered Compilers",
        "java.awt.graphicsenv = sun.awt.X11GraphicsEnvironment",
        "oracle.installer.install.showproductversion = true",
        "oracle.installer.wait = true",
        "oracle.installer.printtimeverbose = false",
        "oracle.installer.clusterEnabled = true",
        "oracle.install.asm.util.kfod.KFOD_ORACLE_HOME = /u02/app/19.3.0/grid",
        "oracle.installer.depHomesOnly = false",
        "oracle.installer.configWizard = true",
        "oracle.installer.clone = false",
        "oracle.installer.removeAllPatches = false",
        "java.vm.specification.version = 1.8",
        "oracle.installer.installUpdates = false",
        "awt.toolkit = sun.awt.X11.XToolkit",
        "oracle.installer.remotecopy.standalone = true",
        "sun.cpu.isalist = ",
        "oracle.installer.entryPoint = oracle.crs_Complete_cluster_install",
        "java.ext.dirs = /u02/app/19.3.0/grid/jdk/jre/lib/ext:/usr/java/packages/lib/ext",
        "oracle.installer.forceClone = false",
        "os.version = 4.1.12-124.16.4.el7uek.x86_64",
        "oracle.installer.appendConfigCommands = false",
        "application.commandline.toolName = gridSetup.sh",
        "oracle.installer.backupInventory = true",
        "user.home = /home/grid",
        "oracle.installer.testForAutoUpdates = false",
        "java.vm.vendor = Oracle Corporation",
        "oracle.installer.h = false",
        "oracle.installer.skipLogsToHome = false",
        "oracle.installer.exitOnStopInstall = false",
        "oracle.installer.splash = true",
        "oracle.installer.putTimestamp = false",
        "oracle.installer.mandatorySetup = false",
        "user.dir = /u02/app/19.3.0/grid",
        "oracle.installer.setCustomNodelist = true",
        "oracle.installer.printtime = true",
        "oracle.installer.executeRemotePrereqs = false",
        "oracle.installer.updateNodeListEx = false",
        "oracle.installer.exitonback = false",
        "oracle.installer.oh_admin_acl = false",
        "oracle.installer.responseFile = /u02/stage/gridsetup19c.rsp",
        "oracle.install.cvu.prereq_xml_loc = /u02/app/19.3.0/grid/cv/cvdata/cvu_prereq.xml",
        "sun.cpu.endian = little",
        "oracle.installer.sessionType = Install",
        "oracle.sysman.prov.PathsPropertiesLoc = /u02/app/19.3.0/grid/oui/prov/resources",
        "oracle.installer.link = true",
        "oracle.installer.library_loc = /u02/app/19.3.0/grid/oui/lib/linux64",
        "java.vm.version = 25.201-b09",
        "ORACLE_HOME = /u02/app/19.3.0/grid",
        "java.class.path = /u02/app/19.3.0/grid/install/jlib/installcommons_1.0.0b.jar:/u02/app/19.3.0/grid/install/jlib/instcommon.jar:/u02/app/19.3.0/grid/install/jlib/instcrs.jar:/u02/app/19.3.0/grid/install/jlib/pilot_1.0.0b.jar:/u02/app/19.3.0/grid/install/jlib/instdb.jar:/u02/app/19.3.0/grid/install/jlib/instclient.jar:/u02/app/19.3.0/grid/install/jlib/emCoreConsole.jar:/u02/app/19.3.0/grid/jlib/cvu.jar:/u02/app/19.3.0/grid/jlib/srvmhas.jar:/u02/app/19.3.0/grid/jlib/srvmasm.jar:/u02/app/19.3.0/grid/jlib/gns.jar:/u02/app/19.3.0/grid/jlib/srvm.jar:/u02/app/19.3.0/grid/jlib/oraclepki.jar:/u02/app/19.3.0/grid/jlib/mgmtca.jar:/u02/app/19.3.0/grid/jlib/mgmtua.jar:/u02/app/19.3.0/grid/jlib/clscred.jar:/u02/app/19.3.0/grid/jlib/oracle.dbtools-common.jar:/u02/app/19.3.0/grid/jlib/wsclient_extended.jar:/u02/app/19.3.0/grid/jlib/adf-share-ca.jar:/u02/app/19.3.0/grid/jlib/jmxspi.jar:/u02/app/19.3.0/grid/jlib/emca.jar:/u02/app/19.3.0/grid/jlib/entityManager_proxy.jar:/u02/app/19.3.0/grid/jlib/javax.security.jacc_1.0.0.0_1-1.jar:/u02/app/19.3.0/grid/jlib/orai18n-mapping.jar:/u02/app/19.3.0/grid/jlib/orai18n-utility.jar:/u02/app/19.3.0/grid/jlib/orai18n-translation.jar:/u02/app/19.3.0/grid/jlib/jwc-cred.jar:/u02/app/19.3.0/grid/jdbc/lib/ojdbc8.jar:/u02/app/19.3.0/grid/OPatch/jlib/opatchsdk.jar:/u02/app/19.3.0/grid/OPatch/jlib/opatch.jar:/u02/app/19.3.0/grid/oui/jlib/OraPrereqChecks.jar:/u02/app/19.3.0/grid/oui/jlib/prov_fixup.jar:/u02/app/19.3.0/grid/oui/jlib/ssh.jar:/u02/app/19.3.0/grid/oui/jlib/jsch.jar:/u02/app/19.3.0/grid/oui/jlib/remoteinterfaces.jar:/u02/app/19.3.0/grid/oui/jlib/OraPrereq.jar:/u02/app/19.3.0/grid/oui/jlib/com.oracle.glcm.patch.opatch-common-api-schema_13.9.3.0.jar:/u02/app/19.3.0/grid/oui/jlib/share.jar:/u02/app/19.3.0/grid/oui/jlib/OraSuiteInstaller.jar:/u02/app/19.3.0/grid/oui/jlib/InstHelp_pt_BR.jar:/u02/app/19.3.0/grid/oui/jlib/InstHelp_fr.jar:/u02/app/19.3.0/grid/oui/jlib/InstHelp_ja.jar:/u02/app/19.3.0/grid/oui/jlib/swingaccess.jar:/u02/app/19.3.0/grid/oui/jlib/ewt3.jar:/u02/app/19.3.0/grid/oui/jlib/InstHelp_es.jar:/u02/app/19.3.0/grid/oui/jlib/xml.jar:/u02/app/19.3.0/grid/oui/jlib/OraInstallerNet.jar:/u02/app/19.3.0/grid/oui/jlib/com.oracle.glcm.patch.opatch-common-api-interfaces_13.9.3.0.jar:/u02/app/19.3.0/grid/oui/jlib/jewt4.jar:/u02/app/19.3.0/grid/oui/jlib/emCfg.jar:/u02/app/19.3.0/grid/oui/jlib/oui.jar:/u02/app/19.3.0/grid/oui/jlib/filesList.jar:/u02/app/19.3.0/grid/oui/jlib/InstHelp.jar:/u02/app/19.3.0/grid/oui/jlib/orai18n-collation.jar:/u02/app/19.3.0/grid/oui/jlib/ohj.jar:/u02/app/19.3.0/grid/oui/jlib/InstHelp_zh_CN.jar:/u02/app/19.3.0/grid/oui/jlib/com.oracle.glcm.patch.opatch-common-api_13.9.3.0.jar:/u02/app/19.3.0/grid/oui/jlib/InstHelp_it.jar:/u02/app/19.3.0/grid/oui/jlib/InstHelp_zh_TW.jar:/u02/app/19.3.0/grid/oui/jlib/classes12.jar:/u02/app/19.3.0/grid/oui/jlib/xmlparserv2.jar:/u02/app/19.3.0/grid/oui/jlib/http_client.jar:/u02/app/19.3.0/grid/oui/jlib/OraCheckPoint.jar:/u02/app/19.3.0/grid/oui/jlib/oneclick.jar:/u02/app/19.3.0/grid/oui/jlib/InstHelp_de.jar:/u02/app/19.3.0/grid/oui/jlib/InstImages.jar:/u02/app/19.3.0/grid/oui/jlib/ojmisc.jar:/u02/app/19.3.0/grid/oui/jlib/oracle_ice.jar:/u02/app/19.3.0/grid/oui/jlib/InstHelp_ko.jar:/u02/app/19.3.0/grid/oui/jlib/help-share.jar:/u02/app/19.3.0/grid/oui/jlib/OraInstaller.jar:/u02/app/19.3.0/grid/oui/jlib/ewt3-swingaccess.jar",
        "oracle.installer.oneclick = false",
        "oracle.installer.ouiApiMode = true",
        "os.arch = amd64",
        "oracle.installer.attachHome = false",
        "oracle.installer.addLangs = false",
        "oracle.installer.ignoreDiskWarning = false",
        "oracle.installer.createLinkBackup = true",
        "oracle.installer.compsdeinstall = true",
        "oracle.installer.homepermissioncheck = true",
        "oracle.installer.force = false",
        "oracle.installer.cfs = false",
        "oracle.installer.repeat = true",
        "oracle.installer.doNotUpdateNodeList = true",
        "sun.java.launcher = SUN_STANDARD",
        "CV_HOME = /u02/app/19.3.0/grid",
        "java.vm.specification.vendor = Oracle Corporation",
        "oracle.installer.showLoadProgress = false",
        "oracle.installer.defaultifyLanguages = false",
        "file.separator = /",
        "oracle.installer.ignorePreReq = false",
        "CVU_OS_SETTINGS = SHELL_NOFILE_SOFT_LIMIT:131072,SHELL_STACK_SOFT_LIMIT:10240,SHELL_UMASK:0022",
        "java.runtime.version = 1.8.0_201-b09",
        "sun.boot.class.path = /u02/app/19.3.0/grid/jdk/jre/lib/resources.jar:/u02/app/19.3.0/grid/jdk/jre/lib/rt.jar:/u02/app/19.3.0/grid/jdk/jre/lib/sunrsasign.jar:/u02/app/19.3.0/grid/jdk/jre/lib/jsse.jar:/u02/app/19.3.0/grid/jdk/jre/lib/jce.jar:/u02/app/19.3.0/grid/jdk/jre/lib/charsets.jar:/u02/app/19.3.0/grid/jdk/jre/lib/jfr.jar:/u02/app/19.3.0/grid/jdk/jre/classes",
        "oracle.installer.inventory_location = /u02/app/oraInventory",
        "java.security.policy = jar:file:/u02/app/19.3.0/grid/install/jlib/installcommons_1.0.0b.jar!/oracle/install/commons/base/driver/common/installer.policy",
        "oracle.installer.ignoreExitCode = true",
        "oracle.installer.relink = false",
        "user.country = US",
        "oracle.installer.ignoreSysPrereqs = false",
        "oracle.installer.debug = false",
        "oracle.installer.remoteInvocation = false",
        "oracle.installer.local = false",
        "oracle.installer.useExistingInventory = true",
        "oracle.installer.clusterSwitch = false",
        "oracle.installer.background = true",
        "java.vendor = Oracle Corporation",
        "oracle.installer.logCopyRequired = false",
        "java.specification.version = 1.8",
        "oracle.installer.logPrefix = gridSetupActions",
        "sun.arch.data.model = 64",
        "==========================================================================================================================================",
        "INFO: Initializing Logs dir to - /u02/app/oraInventory/logs",
        "INFO: Setting variable 'INVENTORY_LOCATION' to '/u02/app/oraInventory'. Received the value from a code block.",
        "INFO: Created OiicStandardInventorySession.",
        "INFO: Checkpoint:getting indexSession from checkpoint factory",
        "INFO: Checkpoint:Index file :/u02/app/19.3.0/grid/install/checkpoints/oui/index.xml not found.",
        "INFO: Checkpoint:Initializing checkpoint session in oiicUpdateNodeList.",
        "INFO: Checkpoint:Location is- /u02/app/19.3.0/grid/install",
        "INFO: Checkpoint:Initializing checkpoint session in oiicUpdateNodeList.",
        "INFO: Checkpoint:Index session object added to oiicexitops.",
        "INFO: Checkpoint:Initializing checkpoint session for UpdateNodeList.",
        "INFO: Checkpoint:checkpointfile :/u02/app/19.3.0/grid/install/checkpoints/oui/checkpoint_null.xml not found,creating one for this session",
        "INFO: Checkpoint:constructing checkpoint with name:oracle.installer.updateNodeList in checkpoint factory",
        "INFO: Setting variable 'CLUSTER_NODES' to 'ora-x1,ora-x2'. Received the value from a code block.",
        "INFO: CRS clusterware not found. Defaulting to vendor clusterware.",
        "INFO: Vendor clusterware is not detected.",
        "INFO: Local node 'ora-x1' is derived from the cluster node list.",
        "INFO: Setting variable 'LOCAL_NODE' to 'ora-x1'. Received the value from a code block.",
        "INFO: Setting variable 'REMOTE_NODES' to 'ora-x2'. Received the value from a code block.",
        "INFO: Saving the install inventory which has the access of 1",
        "INFO: Saving a backup of central inventory.",
        "INFO: The flags set for this home (/u02/app/19.3.0/grid) are:localnode|crs",
        "INFO: Updating XML inventory.",
        "INFO: Saving a backup of inventory for home:/u02/app/19.3.0/grid",
        "INFO: Setting permission on dir : /u02/app/19.3.0/grid/inventory/backup",
        "INFO: Executing command find /u02/app/19.3.0/grid/inventory/backup -type d -exec chmod  -f 0750 {} \";\" ",
        "INFO: Executing command find /u02/app/19.3.0/grid/inventory/backup -type f -exec chmod  -f 0640 {} \";\" ",
        "INFO: Saving comps.xml for /u02/app/19.3.0/grid",
        "INFO: Setting permission on dir : /u02/app/19.3.0/grid/inventory/ContentsXML",
        "INFO: Executing command find /u02/app/19.3.0/grid/inventory/ContentsXML -type d -exec chmod  -f 0750 {} \";\" ",
        "INFO: Executing command find /u02/app/19.3.0/grid/inventory/ContentsXML -type f -exec chmod  -f 0640 {} \";\" ",
        "INFO: Setting permission on dir : /u02/app/oraInventory/ContentsXML /u02/app/oraInventory/logs /u02/app/oraInventory/backup  /u02/app/oraInventory/oraInst.loc",
        "INFO: Executing command find /u02/app/oraInventory/ContentsXML /u02/app/oraInventory/logs /u02/app/oraInventory/backup  /u02/app/oraInventory/oraInst.loc -type d -exec chmod  -f 0770 {} \";\" ",
        "INFO: Executing command find /u02/app/oraInventory/ContentsXML /u02/app/oraInventory/logs /u02/app/oraInventory/backup  /u02/app/oraInventory/oraInst.loc -type f -exec chmod  -f 0660 {} \";\" ",
        "INFO: Executing command find /u02/app/oraInventory/logs -type f -exec chmod  -f 0640 {} \";\" ",
        "INFO: Current Inventory:",
        "\tOracle Home: OraGI19Home1",
        "\t\tOracle Grid Infrastructure 19c 19.0.0.0.0 ",
        "\t\tJava Development Kit 1.8.0.201.0 ",
        "\t\toracle.swd.oui.core.min 12.2.0.7.0 ",
        "\t\tInstaller SDK Component 12.2.0.7.0 ",
        "\t\tOracle One-Off Patch Installer 12.2.0.1.15 ",
        "\t\tOracle Universal Installer 12.2.0.7.0 ",
        "\t\tTomcat Container 19.0.0.0.0 ",
        "\t\tOracle Grid Infrastructure Bundled Agents 19.0.0.0.0 ",
        "\t\tOracle Core Required Support Files for Core DB 19.0.0.0.0 ",
        "\t\tOracle Grid Management Database 19.0.0.0.0 ",
        "\t\tOracle USM Deconfiguration 19.0.0.0.0 ",
        "\t\tOracle DBCA Deconfiguration 19.0.0.0.0 ",
        "\t\tOracle Quality of Service Management (Server) 19.0.0.0.0 ",
        "\t\tUniversal Storage Manager Files 19.0.0.0.0 ",
        "\t\tOracle Text Required Support Files 19.0.0.0.0 ",
        "\t\tOracle JDBC Server Support Package 19.0.0.0.0 ",
        "\t\tDatabase Workspace Manager 19.0.0.0.0 ",
        "\t\tHadoopcore Component 19.0.0.0.0 ",
        "\t\tAutomatic Storage Management Assistant 19.0.0.0.0 ",
        "\t\tOracle Database 19c Multimedia Files 19.0.0.0.0 ",
        "\t\tOracle Multimedia Java Advanced Imaging 19.0.0.0.0 ",
        "\t\tOracle Globalization Support 19.0.0.0.0 ",
        "\t\tOracle Multimedia Locator Java Required Support Files 19.0.0.0.0 ",
        "\t\tOracle Multimedia Locator RDBMS Files 19.0.0.0.0 ",
        "\t\tOracle Bali Share 11.1.1.6.0 ",
        "\t\tOracle Globalization Support For Core 19.0.0.0.0 ",
        "\t\tExpat libraries 2.0.1.0.4 ",
        "\t\tBLASLAPACK Component 19.0.0.0.0 ",
        "\t\tDB TOOLS Listener 19.0.0.0.0 ",
        "\t\tOracle Database Deconfiguration 19.0.0.0.0 ",
        "\t\tRHP Files for Common 19.0.0.0.0 ",
        "\t\tRHP Files for DB 19.0.0.0.0 ",
        "\t\tPerl Modules 5.28.1.0.0 ",
        "\t\tOracle JVM For Core 19.0.0.0.0 ",
        "\t\tPerl Interpreter 5.28.1.0.0 ",
        "\t\tSecure Socket Layer 19.0.0.0.0 ",
        "\t\tOracle Universal Connection Pool 19.0.0.0.0 ",
        "\t\tOracle JDBC/OCI Instant Client 19.0.0.0.0 ",
        "\t\tOracle Multimedia Client Option 19.0.0.0.0 ",
        "\t\tOracle Java Client 19.0.0.0.0 ",
        "\t\tDatabase Migration Assistant for Unicode 19.0.0.0.0 ",
        "\t\tOracle JFC Extended Windowing Toolkit 11.1.1.6.0 ",
        "\t\tOLAP SQL Scripts 19.0.0.0.0 ",
        "\t\tPL/SQL Embedded Gateway 19.0.0.0.0 ",
        "\t\tDatabase SQL Scripts 19.0.0.0.0 ",
        "\t\tSSL Required Support Files for InstantClient 19.0.0.0.0 ",
        "\t\tLDAP Required Support Files 19.0.0.0.0 ",
        "\t\tSQL*Plus Files for Instant Client 19.0.0.0.0 ",
        "\t\tOracle Net Required Support Files 19.0.0.0.0 ",
        "\t\tOracle Notification Service for Instant Client 19.0.0.0.0 ",
        "\t\tDeinstallation Tool 19.0.0.0.0 ",
        "\t\tOracle Locale Builder 19.0.0.0.0 ",
        "\t\tXML Parser for Java 19.0.0.0.0 ",
        "\t\tOracle Security Developer Tools 19.0.0.0.0 ",
        "\t\tOracle Wallet Manager 19.0.0.0.0 ",
        "\t\tInstallation Plugin Files 19.0.0.0.0 ",
        "\t\tPlatform Required Support Files 19.0.0.0.0 ",
        "\t\tOracle Help Share Library 11.1.1.7.0 ",
        "\t\tOracle Help for Java 11.1.1.7.0 ",
        "\t\tRDBMS Required Support Files for Instant Client 19.0.0.0.0 ",
        "\t\tOracle Extended Windowing Toolkit 11.1.1.6.0 ",
        "\t\toracle.swd.commonlogging 13.3.0.0.0 ",
        "\t\tTracle File Analyzer 19.0.0.0.0 ",
        "\t\toracle.swd.opatchautodb 12.2.0.1.5 ",
        "\t\tOracle LDAP administration 19.0.0.0.0 ",
        "\t\tRHP Files for CRS 19.0.0.0.0 ",
        "\t\tCluster Verification Utility Files 19.0.0.0.0 ",
        "\t\tRDBMS Required Support Files 19.0.0.0.0 ",
        "\t\tCluster Verification Utility CRS Files 19.0.0.0.0 ",
        "\t\tCluster Verification Utility Common Files 19.0.0.0.0 ",
        "\t\tOracle Clusterware RDBMS Files 19.0.0.0.0 ",
        "\t\tOracle Ice Browser 11.1.1.7.0 ",
        "\t\tOracle Globalization Support 19.0.0.0.0 ",
        "\t\tBuildtools Common Files 19.0.0.0.0 ",
        "\t\tOracle RAC Required Support Files-HAS 19.0.0.0.0 ",
        "\t\tSQL*Plus Required Support Files 19.0.0.0.0 ",
        "\t\tXDK Required Support Files 19.0.0.0.0 ",
        "\t\tParser Generator Required Support Files 19.0.0.0.0 ",
        "\t\tPrecompiler Required Support Files 19.0.0.0.0 ",
        "\t\tInstallation Common Files 19.0.0.0.0 ",
        "\t\tOracle Core Required Support Files 19.0.0.0.0 ",
        "\t\tHAS Common Files 19.0.0.0.0 ",
        "\t\tRequired Support Files 19.0.0.0.0 ",
        "\t\tOracle JDBC/THIN Interfaces 19.0.0.0.0 ",
        "\t\tOracle Multimedia Locator 19.0.0.0.0 ",
        "\t\tAssistant Common Files 19.0.0.0.0 ",
        "\t\tOracle Multimedia 19.0.0.0.0 ",
        "\t\tOracle Netca Client 19.0.0.0.0 ",
        "\t\tOracle Net 19.0.0.0.0 ",
        "\t\tHAS Files for DB 19.0.0.0.0 ",
        "\t\tPL/SQL 19.0.0.0.0 ",
        "\t\tOracle Recovery Manager 19.0.0.0.0 ",
        "\t\tOracle Database Utilities 19.0.0.0.0 ",
        "\t\tOracle Notification Service 19.0.0.0.0 ",
        "\t\tSQL*Plus 19.0.0.0.0 ",
        "\t\tOracle Advanced Security 19.0.0.0.0 ",
        "\t\tCluster Ready Services Files 19.0.0.0.0 ",
        "\t\tDatabase Configuration and Upgrade Assistants 19.0.0.0.0 ",
        "\t\tOracle JVM 19.0.0.0.0 ",
        "\t\tOracle Internet Directory Client 19.0.0.0.0 ",
        "\t\tOracle Net Listener 19.0.0.0.0 ",
        "\t\tOracle Database 19c 19.0.0.0.0 ",
        "\t\tInterim Patch# 29401763",
        "\t\tInterim Patch# 29517242",
        "\t\tInterim Patch# 29517247",
        "\t\tInterim Patch# 29585399",
        "",
        "INFO: Starting remote cmd threads...............",
        "INFO: All remote cmd threads started...............",
        "INFO: New thread started for node : ora-x2",
        "INFO: Running command '/u02/app/19.3.0/grid/oui/bin/runInstaller  -paramFile /u02/app/19.3.0/grid/oui/clusterparam.ini  -silent -ignoreSysPrereqs -updateNodeList -setCustomNodelist -noClusterEnabled ORACLE_HOME=/u02/app/19.3.0/grid \"CLUSTER_NODES={ora-x1,ora-x2}\" \"NODES_TO_SET={ora-x1,ora-x2}\" CRS=true  LOCAL_NODE=ora-x2 -remoteInvocation -invokingNodeName ora-x1 -logFilePath \"/u02/app/oraInventory/logs\" -timestamp 2019-09-20_00-20-51AM -doNotUpdateNodeList ' on the nodes 'ora-x2'.",
        "INFO: Invoking OUI on cluster nodes ora-x2",
        "INFO: /u02/app/19.3.0/grid/oui/bin/runInstaller  -paramFile /u02/app/19.3.0/grid/oui/clusterparam.ini  -silent -ignoreSysPrereqs -updateNodeList -setCustomNodelist -noClusterEnabled ORACLE_HOME=/u02/app/19.3.0/grid \"CLUSTER_NODES={ora-x1,ora-x2}\" \"NODES_TO_SET={ora-x1,ora-x2}\" CRS=true  LOCAL_NODE=ora-x2 -remoteInvocation -invokingNodeName ora-x1 -logFilePath \"/u02/app/oraInventory/logs\" -timestamp 2019-09-20_00-20-51AM -doNotUpdateNodeList ",
        "INFO: Command execution completes for node : ora-x2",
        "INFO: Command execution sucess for node : ora-x2",
        "INFO: All threads completed its operations",
        "INFO: Checkpoint:Index file written and updated",
        "INFO: Done calling doOperation.",
        "INFO: 'UpdateNodeList' was successful."
    ]
}

TASK [racgi19c_install : Add oratab entry to first node] *********************************************************
changed: [192.168.56.102]

TASK [racgi19c_install : Add oratab entry to second node] ********************************************************
changed: [192.168.56.103]

TASK [racgi19c_install : Check CRS resources and status] *********************************************************
changed: [192.168.56.102]

TASK [racgi19c_install : debug] **********************************************************************************
ok: [192.168.56.102] => {
    "crsctl_resstat.stdout_lines": [
        "--------------------------------------------------------------------------------",
        "Name           Target  State        Server                   State details       ",
        "--------------------------------------------------------------------------------",
        "Local Resources",
        "--------------------------------------------------------------------------------",
        "ora.LISTENER.lsnr",
        "               ONLINE  ONLINE       ora-x1                   STABLE",
        "               ONLINE  ONLINE       ora-x2                   STABLE",
        "ora.chad",
        "               ONLINE  ONLINE       ora-x1                   STABLE",
        "               ONLINE  ONLINE       ora-x2                   STABLE",
        "ora.net1.network",
        "               ONLINE  ONLINE       ora-x1                   STABLE",
        "               ONLINE  ONLINE       ora-x2                   STABLE",
        "ora.ons",
        "               ONLINE  ONLINE       ora-x1                   STABLE",
        "               ONLINE  ONLINE       ora-x2                   STABLE",
        "ora.proxy_advm",
        "               OFFLINE OFFLINE      ora-x1                   STABLE",
        "               OFFLINE OFFLINE      ora-x2                   STABLE",
        "--------------------------------------------------------------------------------",
        "Cluster Resources",
        "--------------------------------------------------------------------------------",
        "ora.ASMNET1LSNR_ASM.lsnr(ora.asmgroup)",
        "      1        ONLINE  ONLINE       ora-x1                   STABLE",
        "      2        ONLINE  ONLINE       ora-x2                   STABLE",
        "      3        OFFLINE OFFLINE                               STABLE",
        "ora.DATA.dg(ora.asmgroup)",
        "      1        ONLINE  ONLINE       ora-x1                   STABLE",
        "      2        ONLINE  ONLINE       ora-x2                   STABLE",
        "      3        OFFLINE OFFLINE                               STABLE",
        "ora.LISTENER_SCAN1.lsnr",
        "      1        ONLINE  ONLINE       ora-x2                   STABLE",
        "ora.LISTENER_SCAN2.lsnr",
        "      1        ONLINE  ONLINE       ora-x1                   STABLE",
        "ora.LISTENER_SCAN3.lsnr",
        "      1        ONLINE  ONLINE       ora-x1                   STABLE",
        "ora.asm(ora.asmgroup)",
        "      1        ONLINE  ONLINE       ora-x1                   Started,STABLE",
        "      2        ONLINE  ONLINE       ora-x2                   Started,STABLE",
        "      3        OFFLINE OFFLINE                               STABLE",
        "ora.asmnet1.asmnetwork(ora.asmgroup)",
        "      1        ONLINE  ONLINE       ora-x1                   STABLE",
        "      2        ONLINE  ONLINE       ora-x2                   STABLE",
        "      3        OFFLINE OFFLINE                               STABLE",
        "ora.cvu",
        "      1        ONLINE  ONLINE       ora-x1                   STABLE",
        "ora.ora-x1.vip",
        "      1        ONLINE  ONLINE       ora-x1                   STABLE",
        "ora.ora-x2.vip",
        "      1        ONLINE  ONLINE       ora-x2                   STABLE",
        "ora.qosmserver",
        "      1        ONLINE  ONLINE       ora-x1                   STABLE",
        "ora.scan1.vip",
        "      1        ONLINE  ONLINE       ora-x2                   STABLE",
        "ora.scan2.vip",
        "      1        ONLINE  ONLINE       ora-x1                   STABLE",
        "ora.scan3.vip",
        "      1        ONLINE  ONLINE       ora-x1                   STABLE",
        "--------------------------------------------------------------------------------"
    ]
}

TASK [racgi19c_install : Check cluster status] *******************************************************************
changed: [192.168.56.102]

TASK [racgi19c_install : debug] **********************************************************************************
ok: [192.168.56.102] => {
    "cluster_stat.stdout_lines": [
        "**************************************************************",
        "ora-x1:",
        "CRS-4537: Cluster Ready Services is online",
        "CRS-4529: Cluster Synchronization Services is online",
        "CRS-4533: Event Manager is online",
        "**************************************************************",
        "ora-x2:",
        "CRS-4537: Cluster Ready Services is online",
        "CRS-4529: Cluster Synchronization Services is online",
        "CRS-4533: Event Manager is online",
        "**************************************************************"
    ]
}

TASK [racgi19c_install : Check ASM cluster mode] *****************************************************************
changed: [192.168.56.102]

TASK [racgi19c_install : debug] **********************************************************************************
ok: [192.168.56.102] => {
    "asmcluster_mode.stdout_lines": [
        "ASM cluster : Flex mode enabled - Direct Storage Access"
    ]
}

TASK [racgi19c_install : bash_profile for user grid] *************************************************************
ok: [192.168.56.102]
ok: [192.168.56.103]

TASK [racgi19c_install : Remove stage directory] *****************************************************************
changed: [192.168.56.102] => (item=/u02/stage)
changed: [192.168.56.103] => (item=/u02/stage)

TASK [racgi19c_install : display post install message] ***********************************************************
ok: [192.168.56.102] => {
    "msg": [
        "This Steps completed below task for Single Instance at 2019-09-19T13:42:02Z:",
        "- Install Oracle Grid Infrastructure 19c on two node RAC cluster ora-x1 and ora-x2",
        "- END OF ALL: git repository GI_19cSoftInstall will be shared"
    ]
}
ok: [192.168.56.103] => {
    "msg": [
        "This Steps completed below task for Single Instance at 2019-09-19T13:42:02Z:",
        "- Install Oracle Grid Infrastructure 19c on two node RAC cluster ora-x1 and ora-x2",
        "- END OF ALL: git repository GI_19cSoftInstall will be shared"
    ]
}

PLAY RECAP *******************************************************************************************************
192.168.56.102             : ok=33   changed=19   unreachable=0    failed=0
192.168.56.103             : ok=17   changed=8    unreachable=0    failed=0
