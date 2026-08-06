#!/usr/bin/env bash
. /usr/share/beakerlib/beakerlib.sh || exit 1

rlJournalStart
    rlPhaseStartSetup
        rlRun "rlImport /library/upstream_library"
        rlRun "rlImport leapp_lib"
        source "$TMT_PLAN_DATA/leapp_test_env.sh"
    rlPhaseEnd
    rlPhaseStartTest "Remediation: leapp_remote_using_root (disabled variant)"
        managed_node=$(echo "$managed_nodes" | awk '{print $1}')
        playbook="$coll_path/roles/remediate/tests/tests_remediation.yml"
        export REMEDIATION_NAME="leapp_remote_using_root_disabled"
        export INHIBITOR_NAME="leapp_remote_using_root"
        export SKIP_RESOLUTION_CHECK=true
        LOGFILE="remediation-leapp_remote_using_root_disabled-${managed_node}-ANSIBLE-${SR_ANSIBLE_VER}"
        lsrRunPlaybook "$playbook" "" "$SR_SKIP_TAGS" "$managed_node" "$LOGFILE" "$SR_ANSIBLE_VERBOSITY"
    rlPhaseEnd
    rlPhaseStartCleanup
        lsrSubmitManagedNodesLogs
    rlPhaseEnd
rlJournalEnd
