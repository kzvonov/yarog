/**
 * Party Module
 * Handles loading and rendering party members
 */

const Party = (function () {
  'use strict';

  async function load({ State, API }) {
    if (!State.settings.serverUrl || !State.settings.heroCode) return;

    const btn = document.getElementById('partyRefresh');
    btn.classList.add('loading');

    try {
      const result = await API.get('/api/game/party', {
        code: State.settings.heroCode
      });

      if (result.status === 'ok' && result.party && result.party.length > 0) {
        render(result.party);
      }
    } catch (err) {
      console.log(err);
    } finally {
      btn.classList.remove('loading');
    }
  }

  function render(party) {
    const list = document.getElementById('partyList');

    list.innerHTML = party.map(member => `
      <tr>
        <td>${escape(member.name) || '???'}</td>
        <td>${escape(member.origin) || '???'}</td>
        <td>${escape(member.klass) || '—'}</td>
        <td>${member.level || 0}</td>
        <td>${member.hp_current || 0}/${member.hp_max || 0}</td>
        <td>${escape(member.armor)}</td>
        <td>${escape(member.damage) || '—'}</td>
      </tr>
    `).join('');
  }

  function escape(text) {
    if (!text) return '';
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
  }

  return {
    load
  };
})();
