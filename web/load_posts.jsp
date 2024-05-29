<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>

<div class="row">
<%
    User uu= (User)session.getAttribute("currentUser");
    Thread.sleep(1000);
 PostDao d= new PostDao(ConnectionProvider.getConnection());
 int cid= Integer.parseInt(request.getParameter("cid"));
 List<Post> posts=null;
   if(cid==0){
      posts = d.getAllPosts();
    }else if(cid>0){
       posts= d.getPostByCatID(cid);
     }
     if(posts.size()==0){
         out.println("<h3 class='display-3 text-center'>No Posts in this Category..</h3>");
         return;
    }
for(Post p: posts){

%>
        <div class="col-mid-6 mt-2">
            <div class="card" style="width: 18rem;">
                <img class="card-img-top" src="blog_pics/<%= p.getpPic() %>" alt="Card image cap">
                <div class="card-body">
                    <b><%= p.getpTitle() %></b>
                    <p><%= p.getpContent() %></p>
                    <pre><%= p.getpCode() %></pre>
                </div>
                <div class="card-footer text-center backgroud-primary">
                    <%
                             LikeDao ld = new LikeDao(ConnectionProvider.getConnection());      
                     %>
                    <a href="show_blog_page.jsp?post_id=<%= p.getPid() %>" class="btn btn-outline-light btn-sm primary-backgroud">Read More..</a>
                    <a href="#!" onclick="doLike(<%= p.getPid()%>,<%= uu.getId() %>)" class="btn btn-outline-light btn-sm primary-backgroud"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%= ld.countLikeOnPost(p.getPid()) %></span> </a>       
                    <a href="#!" class="btn btn-outline-light btn-sm primary-backgroud"><i class="fa fa-commenting-o"></i><span>20</span> </a>
                </div>

            </div>

        </div>


<%
   }


%>
</div>