
#!/bin/bash

SCRIPT_NAME=$1

DTTIME=`date +%Y%m%d_%H:%M:%S`
LOGDIR="/fras/script/logs"
RUNNINGDIR="/fras/script/ODSA_scripts"
WORKINGDIR="/fras/script/ODSA_scripts/WORKING"


for SVRARRAY in `cat ${RUNNINGDIR}/server.list`
do
                SEMFILES=`ls ${WORKINGDIR}/${SVRARRAY}_ODSAscript.sem|wc -l`

                if [ ${SEMFILES} -eq '0' ]
                                then
                                echo "$DTTIME : semaphore started for ${SVRARRAY}" >>${LOGDIR}/healthpdc.log
echo "${SCRIPT_NAME}" > ${WORKINGDIR}/${SVRARRAY}_ODSAscript.sem
                else
                                                SEMFILES1=`grep -ic 'healthcheck_bdc' ${WORKINGDIR}/${SVRARRAY}_ODSAscript.sem`
                                                if [ ${SEMFILES1} -eq '0' ]
                                                then
                                                                echo "$DTTIME : semaphore started for ${SVRARRAY}" >>${LOGDIR}/healthpdc.log
                                                                echo "${SCRIPT_NAME}" > ${WORKINGDIR}/${SVRARRAY}_ODSAscript.sem
                                                else
                                                                echo "$DTTIME : ${WORKINGDIR}/${SVRARRAY} is running already" >>${LOGDIR}/healthpdc.log
                                                fi

                fi
done

