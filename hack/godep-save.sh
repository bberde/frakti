#!/bin/bash

# Copyright 2016 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit
set -o nounset
set -o pipefail

FRAKTI_ROOT=$(dirname "${BASH_SOURCE}")/..
source "${FRAKTI_ROOT}/hack/lib/init.sh"
GODEP="${GODEP:-godep}"


cd ${FRAKTI_ROOT}

# Some things we want in godeps aren't code dependencies, so ./...
# won't pick them up.
REQUIRED_BINS=(
  "github.com/onsi/ginkgo/ginkgo"
  "./..."
)

pushd "${FRAKTI_ROOT}" > /dev/null
  GO15VENDOREXPERIMENT=1 ${GODEP} save "${REQUIRED_BINS[@]}"
popd > /dev/null