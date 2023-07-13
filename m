Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7024675241C
	for <lists+linux-block@lfdr.de>; Thu, 13 Jul 2023 15:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjGMNnY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 13 Jul 2023 09:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbjGMNnH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2023 09:43:07 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03753C0
        for <linux-block@vger.kernel.org>; Thu, 13 Jul 2023 06:43:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 063F46732D; Thu, 13 Jul 2023 15:43:04 +0200 (CEST)
Date:   Thu, 13 Jul 2023 15:43:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: don't allow enabling a write back cache on devices that don't
 support it
Message-ID: <20230713134303.GA25950@lst.de>
References: <20230707094239.107968-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707094239.107968-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens, does this make sense to you?  Without this we can deliver
flush requests to drivers not supporting them, which is a bit nasty
even if it's not exploitable without root-equivalent access.
