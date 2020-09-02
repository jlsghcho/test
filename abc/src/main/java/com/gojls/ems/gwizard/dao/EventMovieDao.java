package com.gojls.ems.gwizard.dao;

import java.util.List;

import com.gojls.ems.gwizard.model.EventMovieModel;
import com.gojls.ems.gwizard.model.EventUserModel;

public interface EventMovieDao {
	public List<EventMovieModel> selectEventMovieList(EventMovieModel eventMovieModel);
	public List<EventMovieModel> selectEventMovieListByUser(EventUserModel eventUserModel);
	public List<EventMovieModel> selectEventRandomMovieList(EventMovieModel eventMovieModel);
	public EventMovieModel selectEventMovie(EventMovieModel eventMovieModel);
}
