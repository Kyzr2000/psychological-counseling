package king.flyz.dao;

import java.util.List;

import king.flyz.pojo.Comment;

public interface CommentMapper {
	public int addComment(Comment c);
	public List<Comment> getCommentListByAnswerID(int answer_id);
	public List<Comment> getCommentList();
}
