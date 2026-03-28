/**
 * API Module
 * Handles all API calls
 */

const API = (function() {
  'use strict';

  const BASE_URL = '/api';

  /**
   * Generic fetch wrapper
   */
  async function request(url, options = {}) {
    try {
      const response = await fetch(`${BASE_URL}${url}`, {
        headers: {
          'Content-Type': 'application/json',
          ...options.headers
        },
        ...options
      });

      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }

      return await response.json();
    } catch (error) {
      console.error('API request failed:', error);
      throw error;
    }
  }

  /**
   * Get hero by ID
   */
  async function getHero(heroId) {
    return request(`/heroes/${heroId}`);
  }

  /**
   * Update hero
   */
  async function updateHero(heroId, data) {
    return request(`/heroes/${heroId}`, {
      method: 'PATCH',
      body: JSON.stringify(data)
    });
  }

  /**
   * Create hero
   */
  async function createHero(data) {
    return request('/heroes', {
      method: 'POST',
      body: JSON.stringify(data)
    });
  }

  /**
   * Delete hero
   */
  async function deleteHero(heroId) {
    return request(`/heroes/${heroId}`, {
      method: 'DELETE'
    });
  }

  /**
   * List all heroes
   */
  async function listHeroes() {
    return request('/heroes');
  }

  // Public API
  return {
    getHero,
    updateHero,
    createHero,
    deleteHero,
    listHeroes
  };
})();
