#!/usr/bin/env bash
. /usr/share/beakerlib/beakerlib.sh || exit 1

rlJournalStart
    rlPhaseStartSetup
        rlRun "rlImport /library/upstream_library"
        rlRun "rlImport leapp_lib"
        source "$TMT_PLAN_DATA/leapp_test_env.sh"
    rlPhaseEnd
    rlPhaseStartTest "Remediation: leapp_loaded_removed_kernel_drivers"
        managed_node=$(echo "$managed_nodes" | awk '{print $1}')
        playbook="$coll_path/roles/remediate/tests/tests_remediation.yml"
        export REMEDIATION_NAME="leapp_loaded_removed_kernel_drivers"
        export INHIBITOR_NAME="leapp_loaded_removed_kernel_drivers"
        LOGFILE="remediation-leapp_loaded_removed_kernel_drivers-${managed_node}-ANSIBLE-${SR_ANSIBLE_VER}"
        lsrRunPlaybook "$playbook" "" "$SR_SKIP_TAGS" "$managed_node" "$LOGFILE" "$SR_ANSIBLE_VERBOSITY"
    rlPhaseEnd
    rlPhaseStartCleanup
        lsrSubmitManagedNodesLogs
    rlPhaseEnd
rlJournalEnd
