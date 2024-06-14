class EndPoints{
 static const String baseurl = 'https://hyperedge.online/api';
//signup
static const String signup = '/users/send-otp';
static const String otpurl = '/users/verify-otp';
static const String loginurl = '/users/login';
//post
static const String addposturl = '/posts/addPost';
static const String fetchposturl = '/posts/getpost';
static const String fetchuserposturl = '/posts/getuserpost';
static const String deleteposturl = '/posts/delete-post';
static const String editposturl = '/posts/update-post';
static const String followersposturl = '/posts/allfollowingsPost';
static const String postlikeurl = '/posts/like-post';
static const String postunlikeurl = '/posts/unlike-post';
static const String fetchcommentsurl = '/posts/fetch-comments';
static const String addcommenturl = '/posts/add-comment';
static const String deletecommenturl = '/posts/delete-comment';
static const String saveposturl = '/posts/savePost';
static const String unsaveposturl = '/posts/savePosts';
static const String reportposturl = '/posts/report-post';
static const String savedposturl = '/posts/savePosts';
static const String exploreposturl = '/posts/exploreposts';
//users
static const String connectioncounturl = '/users/get-count';
static const String loginuserurl = '/users/getuser';
static const String editprofileurl = '/users/edit-profile';
static const String suggessionurl = '/users/fetch-users';
static const String followuserurl = '/users/follow';
static const String unfollowuserurl = '/users/unfollow';
static const String isfollowingurl = '/users/isFollowing';
static const String fetchfollowingurl = '/users/fetch-following';
static const String fetchfollowersurl = '/users/fetch-followers';
static const String searchusersurl = '/users/searchallusers?searchQuery=';
static const String getSingleuserurl = '/users/get-single-user';
static const String notificationurl = '/users/notifications';
//chats
static const String getconversationurl = '/chats/conversation';
static const String createconversationurl = '/chats/conversation';
static const String addmessageurl = '/chats/message';
static const String getallmessageurl = '/chats/message';

}