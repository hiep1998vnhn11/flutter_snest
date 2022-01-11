import 'package:get/get.dart';

class PostController extends GetxController {
  RxInt postCount = 0.obs;
  RxBool loading = false.obs;
  RxList posts = [].obs;

  void toggleLoading() {
    loading.value = !loading.value;
  }

  void setPostCount(int count) {
    postCount.value = count;
  }

  void addPostCount(int count) {
    postCount.value += count;
  }

  void addPost(dynamic post) {
    postCount.value++;
    posts.insert(0, post);
  }

  void removePost(int postId) {
    posts.removeWhere((post) => post['id'] == postId);
  }

  void updatePost(dynamic post) {
    final int index = posts.indexWhere((item) => post['id'] == item['id']);
    if (index != -1) posts[index] = post;
  }

  void clearPosts() {
    posts.clear();
  }

  void addAllPosts(List listPost) {
    posts.addAll(listPost);
  }

  @override
  void onClose() {
    postCount.close();
    loading.close();
    posts.close();
  }
}
