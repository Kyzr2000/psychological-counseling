package king.flyz.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import king.flyz.dao.CommentMapper;
import king.flyz.pojo.Comment;
import king.flyz.service.CommentService;

@Service("commentService")
public class CommentServiceImpl implements CommentService {
	@Resource
	private CommentMapper commentMapper;

	@Override
	public int addComment(Comment c) {
		return commentMapper.addComment(c);
	}

	@Override
	public List<Comment> getCommentListByAnswerID(int answer_id) {
		return commentMapper.getCommentListByAnswerID(answer_id);
	}

	@Override
	public int commentNum() {
		List<Comment> list = commentMapper.getCommentList();
		return list.size();
	}
}
