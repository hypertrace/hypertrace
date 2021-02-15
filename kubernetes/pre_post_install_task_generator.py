import re

def create_pre_hook_manifests(source_file, target_file):
    with open (source_file) as manifest_file:
        content = manifest_file.read()
    helm_hooks = re.search(r'(?<=HOOKS:).*(?=MANIFEST)', content, re.DOTALL).group()
    helm_pre_hooks = re.sub(r"#\s(Source)(.*)(?:attribute-service)(.*)(?:config-bootstrapper)(.+)((?:\n.+)+)\n+.+\n.+", "", helm_hooks)
    helm_pre_hooks = re.sub(r"#\s(Source)(.*)(?:entity-service)(.*)(?:config-bootstrapper)(.+)((?:\n.+)+)\n+.+\n.+", "", helm_pre_hooks)
    with open(target_file, "w") as pre_hooks:
        pre_hooks.write(helm_pre_hooks)

def create_post_hook_manifests(source_file, target_file):
    with open (source_file) as manifest_file:
        content = manifest_file.read()
    post_attribute_hooks = re.search(r"#\s(Source)(.*)(?:attribute-service)(.*)(?:config-bootstrapper)(.+)((?:\n.+)+)\n+.+\n.+", content).group()
    post_entity_hooks = re.search(r"#\s(Source)(.*)(?:entity-service)(.*)(?:config-bootstrapper)(.+)((?:\n.+)+)\n+.+", content).group()
    with open(target_file, "w") as post_hooks:
        post_hooks.write(post_attribute_hooks)
        post_hooks.write('\n')
        post_hooks.write(post_entity_hooks)

def main():
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('hooks', help='pre or post hook manifests')
    parser.add_argument('source_file', help='The path of the manifest source file')
    parser.add_argument('target_file', help='The path to store result manifests')
    args = parser.parse_args()
    if args.hooks == "pre":
        create_pre_hook_manifests(args.source_file, args.target_file)
    elif args.hooks == "post":
        create_post_hook_manifests(args.source_file, args.target_file)
    print("manifests created successfully!")
    
if __name__ == '__main__':
    main()

