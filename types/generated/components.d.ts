import type { Struct, Schema } from '@strapi/strapi';

export interface ContentBlocks extends Struct.ComponentSchema {
  collectionName: 'components_content_blocks';
  info: {
    displayName: 'Rich text';
    description: '';
  };
  attributes: {
    body: Schema.Attribute.Blocks & Schema.Attribute.Required;
  };
}

declare module '@strapi/strapi' {
  export module Public {
    export interface ComponentSchemas {
      'content.blocks': ContentBlocks;
    }
  }
}
