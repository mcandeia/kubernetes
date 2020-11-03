#!/bin/bash
function get_manifest() {
    grpcurl -v -insecure ppp.marcos-candeia.com:443 ppp.PaymentProvider.GetManifest
}

$1 $@