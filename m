Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81677587048
	for <lists+linux-block@lfdr.de>; Mon,  1 Aug 2022 20:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbiHASPv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 1 Aug 2022 14:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiHASPu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Aug 2022 14:15:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D7D1122
        for <linux-block@vger.kernel.org>; Mon,  1 Aug 2022 11:15:49 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3A1F068AA6; Mon,  1 Aug 2022 20:15:46 +0200 (CEST)
Date:   Mon, 1 Aug 2022 20:15:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org,
        hch@lst.de, ming.lei@redhat.com
Subject: Re: [PATCH v2 blktests] block/002: remove debugfs check while
 blktests is running
Message-ID: <20220801181545.GA17565@lst.de>
References: <20220730075828.218063-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730075828.218063-1-yi.zhang@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
