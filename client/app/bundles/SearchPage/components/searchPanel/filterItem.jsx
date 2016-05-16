import React, { Component, PropTypes } from 'react';
import toggleFilter from '../../actions/filters';
import classNames from 'classnames';
import _ from 'lodash';

export default class FilterItem extends Component {
  static propTypes = {
    label: PropTypes.string.isRequired,
    facet: PropTypes.string.isRequired,
    count: PropTypes.number.isRequired,
    dispatch: PropTypes.func.isRequired,
    activeFilters: PropTypes.arrayOf(
      PropTypes.shape({
        facet: PropTypes.string.isRequired,
        value: PropTypes.string.isRequired
      })
    ).isRequired
  }

  handleFilterClick(facet, label) {
    const { dispatch } = this.props;

    dispatch(toggleFilter({facet, value: label}))
  }

  render() {
    const { label, count, facet, activeFilters } = this.props;
    const active = _.some(activeFilters, filter => filter.facet === facet && filter.value === label)
    // classNames takes an object in the shape of {css_class_name: boolean}
    // If the boolean is true that class will be applied, if false it will not
    // Makes managing the classes an object has in various states _much_ easier
    const aClass = classNames({active})

    // this.handleFilterClick.bind(this, facet, label) creates a new function
    // that when called by the React event handler will call handleFilterclick 
    // with facet and label as the arguments to handleFilterClick and correctly 
    // set 'this' to the React 'this' instead of the event 'this'
    return (
      <a 
        className={aClass}
        onClick={this.handleFilterClick.bind(this, facet, label)}
        >
        {label} <span className='count'>{count.toLocaleString()}</span>
      </a>
    );
  }
}
