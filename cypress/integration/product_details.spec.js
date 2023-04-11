describe('product details', () => {
  beforeEach(() => {
    cy.visit('http://127.0.0.1:3000/');
  });

  it('can navigate from the home page to the product detail', () => {
    cy.get('.products article a').first().click();
    cy.get('.products-show').should('exist');
    cy.contains('Scented Blade').should('exist');
    cy.contains('18 in stock').should('exist');
  });
});
