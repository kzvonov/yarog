
function switchTab(event, tabId) {

  const targetElement = event.target;
  const tabsParent = targetElement.closest('.tabs');

  if (tabsParent && tabsParent.parentElement) {
    const siblings = Array.from(tabsParent.parentElement.children).filter(sibling =>
      sibling !== tabsParent && sibling.classList.contains('tab-content')
    );
    siblings.forEach(tab => tab.classList.remove('active'));

    Array.from(tabsParent.children).forEach(btn => btn.classList.remove('active'));

    document.getElementById(tabId).classList.add('active');
    event.currentTarget.classList.add('active');
  }
}