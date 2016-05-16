import React, { Component, PropTypes } from 'react';
import FilterItem from './filterItem';
import _ from 'lodash';

export default class FilterTab extends Component {
  static propTypes = {
    facet: PropTypes.string.isRequired,
    values: PropTypes.arrayOf(
      PropTypes.objectOf(PropTypes.number)
    ),
    activeFilters: PropTypes.arrayOf(
      PropTypes.shape({
        facet: PropTypes.string.isRequired,
        value: PropTypes.string.isRequired
      })
    ).isRequired,
    dispatch: PropTypes.func.isRequired
  }

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
