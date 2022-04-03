BLOG_POSTS  = $(shell pwd)/.repo/blog-content/content/posts/zh-cn
BLOG_IMAGES = $(shell pwd)/.repo/blog-images/r

init:
	git submodule update --recursive --init
