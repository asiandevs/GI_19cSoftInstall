echo ""
echo "**************************************"
echo "        ADR Policy Setup              "
echo "**************************************"
echo ""

export ORACLE_BASE=/u02/app/oracle
export ORACLE_SID=eaymp1
export ORACLE_HOME=$ORACLE_BASE/product/19.3.0/db300
export PATH=$PATH:$ORACLE_HOME/bin
date=`date +"%Y%m%d%H%M%S"`
adrci_homes=( $(adrci exec="show homes" | grep -e rdbms))
echo "INFO: setup adrci seting at `date`"
adrci exec="set home $adrci_homes;set control \(SHORTP_POLICY=720, LONGP_POLICY=8760\);purge;exit;";
adrci exec="set home $adrci_homes; show control;" ;
echo
echo "INFO: adrci setup finished at `date`"

