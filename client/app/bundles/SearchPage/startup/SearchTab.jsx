import React from 'react';
import { Provider } from 'react-redux';
import SearchTabContainer from '../containers/SearchTabContainer';
import ReactRails from 'react-on-rails';

export default () => {
	const searchPageStore = ReactRails.getStore('searchPageStore')
	return (
	  <Provider store={searchPageStore}>
	    <SearchTabContainer />
	  </Provider>
	);
};
