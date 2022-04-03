BLOG_REPO   = $(shell pwd)/.repo/blog-content
IMAGE_REPO  = $(shell pwd)/.repo/blog-images
BLOG_POSTS  = $(BLOG_REPO)/content/posts/zh-cn
IMAGE_DIRS  = $(IMAGES_REPO)/r
POSTS_NUMS  = $(shell ls -l $(BLOG_POSTS) | grep "^-" | wc -l)
NEW_FILE_ID = $(shell printf "%03d\n" $(POSTS_NUMS))

GIT = env git

init:
	git submodule update --recursive --init

new: $(BLOG_REPO) $(IMAGE_REPO)
	@NEW_FILE_ID=$(NEW_FILE_ID) make -C $(BLOG_REPO) new 
	@NEW_IMAGE_DIR_ID=$(NEW_FILE_ID) make -C $(IMAGE_REPO) new

build: $(BLOG_POSTS)
	@make -C $(BLOG_REPO) build

dev: $(BLOG_POSTS)
	@-make -C $(BLOG_REPO) dev

commit: $(BLOG_REPO) $(IMAGE_REPO)
	@make -C $(BLOG_REPO) commit
	@make -C $(IMAGE_REPO) commit

push: commit
	@make -C $(BLOG_REPO) push
	@make -C $(IMAGE_REPO) push
	@-$(GIT) add .
	@-$(GIT) commit -m "Update: $(shell date +%Y-%m-%d)"
	@-$(GIT) push

clean: $(BLOG_REPO)
	@make -C $(BLOG_REPO) clean
