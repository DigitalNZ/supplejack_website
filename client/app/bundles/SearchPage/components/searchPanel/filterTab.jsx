import React, { Component } from 'react';
import FilterItem from './filterItem';
import _ from 'lodash';

export default class FilterTab extends Component {

  render() {
    const { values, facet, activeFilters, dispatch } = this.props;

    const tabContent = _.map(values, (count, label) => {
      return <FilterItem 
        key={label}
        facet={facet} 
        count={count} 
        label={label} 
        activeFilters={activeFilters}
        dispatch={dispatch}
        />
    })

    return (
      <div className='content active'>
        <section>
          <ul className='facet-list'>
            {tabContent}
          </ul>
        </section>
      </div>
    );
  }
}
