import re
import yaml

def create_hook_based_manifests(hook, source_file, target_file):
    hook_manifests=open(target_file, 'w')
    with open (source_file, 'r') as manifest_file:
        content = manifest_file.read()
    helm_hooks = re.search(r'(?<=HOOKS:).*(?=MANIFEST)', content, re.DOTALL).group()
    docs = yaml.load_all(helm_hooks, Loader=yaml.FullLoader)
    for doc in docs:
        if (hook in doc["metadata"]["annotations"]["helm.sh/hook"]):
            hook_manifests.writelines("---\n")
            yaml.dump(doc, hook_manifests)

def main():
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('hook', help='pre or post hook manifests')
    parser.add_argument('source_file', help='The path of the manifest source file')
    parser.add_argument('target_file', help='The path to store result manifests')
    args = parser.parse_args()
    create_hook_based_manifests(args.hook, args.source_file, args.target_file)
    print(args.hook, "manifests created successfully!")
    
if __name__ == '__main__':
    main()

