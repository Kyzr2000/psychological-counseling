package king.flyz.service;

import java.util.List;

import king.flyz.pojo.Comment;

public interface CommentService {
	public int addComment(Comment c);
	public List<Comment> getCommentListByAnswerID(int answer_id);
	public int commentNum();
}
