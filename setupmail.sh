#!/bin/bash
# © Copyright IBM Corporation 2023, 2024
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

function line_separator () {
  echo "####################### $1 #######################"
}

echo ""
line_separator "Create namespace "$NAMESPACE
NAMESPACE=cp4i-mail
oc new-project $NAMESPACE 2> /dev/null
oc project $NAMESPACE


echo ""
line_separator "Create mail deployment"
oc apply -f deployment.yaml

echo ""
line_separator "Create mail service"
oc apply -f service.yaml

echo ""
line_separator "Create mail dashboard route"
oc apply -f dashboard-route.yaml

ROUTE_URL=$(oc get route mail-dashboard -o jsonpath={'.spec.host'})
echo ""
echo "maile dashboard URL: http://$ROUTE_URL"
echo ""