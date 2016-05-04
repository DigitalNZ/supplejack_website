import React, { Component } from 'react';
import updateSearchValue from '../actions/updateSearchValue';
import performSearch from '../actions/performSearch';

export default class SearchBox extends Component {
  constructor() {
    super()

    _.bindAll(this, 'onInputChange', 'performSearch')
  }

  onInputChange(e) {
    const { dispatch } = this.props;

    dispatch(updateSearchValue(e.target.value));
  }

  performSearch(e) {
    e.preventDefault();
    const { dispatch } = this.props;

    dispatch(performSearch());
  }

  render() {
    return (
      <div className='container'>
        <div className='row collapse postfix-round'>
          <form onSubmit={this.performSearch} className='search'>
            <div className='small-10 columns'>
              <input type='text' id='search-input' className='search-input' value={this.props.value || ''} placeholder='Enter your search...' onChange={this.onInputChange} />
            </div>
            <div className='small-2 columns'>
              <input type='submit' value='Search' id='search-button' className='search-button button postfix' />
            </div>
          </form>
        </div>
      </div>
    );
  }
}
