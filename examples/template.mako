<%def name="block_v4(action, cidrs)" filter="trim">
    ${action} attribute next-hop ${ipv4} community [ 65142:666 no-export ] nlri ${" ".join(cidrs)}
</%def>
<%def name="block_v6(action, cidrs)" filter="trim">
    ${action} attribute next-hop ${ipv6} community [ 65142:666 no-export ] nlri ${" ".join(cidrs)}
</%def>
<%def name="block(action, cidrs)" filter="trim">
## cidrs are grouped by v4 or v6. If one address is v4, they all are.
%if ':' in cidrs[0]:
    ${block_v6(action, cidrs)}
%else:
    ${block_v4(action, cidrs)}
%endif
</%def>

process bhr-dynamic {
    # auto filled in by bhr-client-exabgp-write-template
    run ${path_to_bhr_client_exabgp_loop};
    encoder text;
}

template {
    neighbor AS_65000 {
        peer-as 65000;
        local-as 64512;
        hold-time 3600;
        router-id ${ip};
        local-address ${ip};
        group-updates;

        api {
            processes [bhr-dynamic];
        }
    }
}
    
neighbor 192.168.2.201 {
    inherit AS_65000;
    description "edge-1";
}