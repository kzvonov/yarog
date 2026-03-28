/**
 * Settings Module
 * Handles app settings (theme, preferences, etc.)
 */

const Settings = (function() {
  'use strict';

  const STORAGE_KEY = 'yarog_settings';
  let currentSettings = {
    theme: 'dark',
    autoSave: true
  };

  /**
   * Load settings from localStorage
   */
  function load() {
    try {
      const saved = localStorage.getItem(STORAGE_KEY);
      if (saved) {
        currentSettings = { ...currentSettings, ...JSON.parse(saved) };
      }
    } catch (error) {
      console.error('Failed to load settings:', error);
    }
    return currentSettings;
  }

  /**
   * Save settings to localStorage
   */
  function save(settings) {
    currentSettings = { ...currentSettings, ...settings };
    try {
      localStorage.setItem(STORAGE_KEY, JSON.stringify(currentSettings));
    } catch (error) {
      console.error('Failed to save settings:', error);
    }
    return currentSettings;
  }

  /**
   * Get current settings
   */
  function get() {
    return { ...currentSettings };
  }

  /**
   * Set theme
   */
  function setTheme(theme) {
    currentSettings.theme = theme;
    document.documentElement.setAttribute('data-theme', theme);
    save(currentSettings);
  }

  /**
   * Toggle theme
   */
  function toggleTheme() {
    const newTheme = currentSettings.theme === 'dark' ? 'light' : 'dark';
    setTheme(newTheme);
    return newTheme;
  }

  /**
   * Initialize settings
   */
  function init() {
    load();
    setTheme(currentSettings.theme);
  }

  // Public API
  return {
    init,
    load,
    save,
    get,
    setTheme,
    toggleTheme
  };
})();
