Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7083E232DD5
	for <lists+linux-block@lfdr.de>; Thu, 30 Jul 2020 10:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgG3IPD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 30 Jul 2020 04:15:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:54524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729978AbgG3IME (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 04:12:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5C842B1E1;
        Thu, 30 Jul 2020 08:12:15 +0000 (UTC)
Date:   Thu, 30 Jul 2020 10:12:02 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-block@vger.kernel.org, Sebastian.Chlad@suse.com,
        daniel.wagner@suse.com, hare@suse.com, osandov@fb.com
Subject: Re: [PATCH] common/multipath-over-rdma: make block scheduler
 directory optional
Message-ID: <20200730081202.ppcwyzbiqj6pahhe@beryllium.lan>
References: <20200729152113.1250-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729152113.1250-1-mcgrof@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Luis,

[cc: Omar]

blktests patches should have a 'PATCH blktests' subject prefix.

On Wed, Jul 29, 2020 at 03:21:13PM +0000, Luis Chamberlain wrote:
> We currently fail if the following tests if the directory
> /lib/modules/$(uname -r)/kernel/block does not exist. Just make
> this optional. Older distributions won't have this directory.

It's not just older distributions. If the I/O schedulers are build in
there wont be any block directory.

> srp/001
> srp/002
> srp/013
> srp/014
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
