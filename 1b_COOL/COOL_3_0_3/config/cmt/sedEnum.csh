#! /bin/csh -f
if ( "$1" == "" ) then
echo "Usage: $0 files"
exit 1
endif

echo "$*"

foreach file ( $* )
  if ( "$file" != "" ) then
    echo "$file"
    if ( -e "$file" ) then
      cat ${file} \
        | sed 's|ChannelSelection::sinceB|ChannelSelection::Order::sinceB|g'\
        | sed 's|ChannelSelection::channelB|ChannelSelection::Order::channelB|g'\
        | sed 's|StorageType::B|StorageType::TypeId::B|g'\
        | sed 's|StorageType::C|StorageType::TypeId::C|g'\
        | sed 's|StorageType::D|StorageType::TypeId::D|g'\
        | sed 's|StorageType::F|StorageType::TypeId::F|g'\
        | sed 's|StorageType::I|StorageType::TypeId::I|g'\
        | sed 's|StorageType::S|StorageType::TypeId::S|g'\
        | sed 's|StorageType::U|StorageType::TypeId::U|g'\
        | sed 's|FolderVersioning::NONE|FolderVersioning::Mode::NONE|g'\
        | sed 's|FolderVersioning::MULTI|FolderVersioning::Mode::MULTI|g'\
        | sed 's|FolderVersioning::SINGLE|FolderVersioning::Mode::SINGLE|g'\
        | sed 's|HvsTagLock::L|HvsTagLock::Status::L|g'\
        | sed 's|HvsTagLock::P|HvsTagLock::Status::P|g'\
        | sed 's|HvsTagLock::U|HvsTagLock::Status::U|g'\
        | sed 's|PayloadMode::I|PayloadMode::Mode::I|g'\
        | sed 's|PayloadMode::S|PayloadMode::Mode::S|g'\
        | sed 's|PayloadMode::V|PayloadMode::Mode::V|g'\
        | sed 's|FieldSelection::NE|FieldSelection::Relation::NE|g'\
        | sed 's|FieldSelection::EQ|FieldSelection::Relation::EQ|g'\
        | sed 's|FieldSelection::G|FieldSelection::Relation::G|g'\
        | sed 's|FieldSelection::L|FieldSelection::Relation::L|g'\
        | sed 's|FieldSelection::IS|FieldSelection::Nullness::IS|g'\
        | sed 's|CompositeSelection::A|CompositeSelection::Connective::A|g'\
        | sed 's|CompositeSelection::O|CompositeSelection::Connective::O|g'\
        | sed 's|IHvsNode::I|IHvsNode::Type::I|g'\
        | sed 's|IHvsNode::L|IHvsNode::Type::L|g'\
        > ${file}.new
      \mv ${file}.new ${file}
    endif
  endif
end

