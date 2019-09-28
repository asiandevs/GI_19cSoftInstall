# GI_19cSoftInstall

This Ansinble playbook is for Oracle Grid Infrastructure Installation, Oracle RAC Installation and Create RAC database 19c 64-bit on Oracle Linux 7 (OL7) 64-bit.

Grid Infrastructure Installation and Upgrade Guide for Linux
https://docs.oracle.com/en/database/oracle/oracle-database/19/cwlin/index.html

Database Installation Guide for Linux
https://docs.oracle.com/en/database/oracle/oracle-database/19/ladbi/index.html

Setup: 
OS: OEL 7.5 
Ansible: ansible 2.7.6

Required Oracle Software: Download the Oracle software from OTN or MOS depending on your support status. Oracle binaries are staged from the "edelivery: Oracle Database 19c Software (64-bit)". They have to be manually downloaded and made available for this article to apply 

Master Playbook:
oracleGInRAC19cR3.yml

There are three roles with this playbook: 
  roles:
   1)  racgi19c_install          # To Install Oracle Grid Infrastructure Installation
   2)  racdbsoft19c_install      # To Install Oracle RAC software installation
   3)  racdb19c_create           # To create Two Node RACDB ~19C 

To Install Oracle Grid Infrastructure Installation:
Enable role 1, disable role 2 and role3 

To Install Oracle RAC software installation
Enable role 2, disable role 1 and role3 [ Pre-step: Role 1 should be completed ]
To create Two Node RACDB ~19C
Enable role 3, disable role 1 and role2 [ Pre-step: Role 1 and 2 should be completed ]

You can one by one or all of them together. Only thing to make sure the sequence.

Summary commands: 

1. Clone this repository:
    git clone https://github.com/asiandevs/GI_19cSoftInstall.git

2. Stage the following Oracle Software on the control machine

Oracle Database 19c Grid Infrastructure (19.3) for Linux x86-64
     - LINUX.X64_193000_grid_home.zip
Oracle Database 19c (19.3) for Linux x86-64 
     - LINUX.X64_193000_db_home.zip

3. Configure an Ansible inventory file (example as below) 
[root@oel75 ansible]# cat ansible.cfg | grep inventory
inventory = ./inventory
[root@oel75 ansible]# cat inventory
[ora-x1]
192.168.56.102

[ora-x2]
192.168.56.103

[oel75]
192.168.56.101

[dbservers]
192.168.56.102
192.168.56.103

4. Run the playbook role "oracleGInRAC19cR3.yml "
ansible-playbook oracleGInRAC19cR3.yml  

Note: Modify variables based on you setup or your requirements. 
