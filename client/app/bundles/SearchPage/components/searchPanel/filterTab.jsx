import React, { Component } from 'react';
import addFilter from '../../actions/addFilter';
import classNames from 'classnames';
import _ from 'lodash';

export default class FilterTab extends Component {
  handleFilterClick(facet, label) {
    const { dispatch } = this.props;

    dispatch(addFilter({facet, value: label}))
  }

  render() {
    const { values, facet, activeFilters } = this.props;

    const tabContent = _.map(values, (count, label) => {
      const aClass = classNames({active: _.includes(activeFilters, label)})
      return (
        <a 
          className={aClass}
          key={label} 
          onClick={this.handleFilterClick.bind(this, facet, label)}
          >
          {label} <span className='count'>{count.toLocaleString()}</span>
        </a>
      );
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
