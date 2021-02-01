import yaml
import sys

kube_config = yaml.safe_load(open(sys.argv[1]))
current_context = kube_config["current-context"] if "current-context" in kube_config else ""
for context in kube_config["contexts"]:
    if current_context == "" or context["name"] == current_context:
        cluster = context['context']['cluster'].split("/")[-1] if 'cluster' in context['context'] else "??"
        namespace = context['context']['namespace'] if 'namespace' in context['context'] else "default"
        print("({} : {})".format(cluster, namespace))
        break
