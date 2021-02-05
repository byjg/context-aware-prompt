import yaml
import sys
import os

kube = os.environ.get("HOME") + "/.kube/config"
kube_src = ".kube"
if os.environ.get("KUBECONFIG"):
    kube = os.environ.get("KUBECONFIG")
    kube_src = "KUBECONFIG"

if not os.path.exists(kube):
    exit(0)

kube_config = yaml.safe_load(open(kube))
current_context = kube_config["current-context"] if "current-context" in kube_config else ""
for context in kube_config["contexts"]:
    if current_context == "" or context["name"] == current_context:
        cluster = context['context']['cluster'].split("/")[-1] if 'cluster' in context['context'] else "??"
        namespace = context['context']['namespace'] if 'namespace' in context['context'] else "default"
        print("[{}][{}:{}]".format(kube_src, cluster, namespace))
        break
